"""
Awesome snippets of code to make your awesome xonsh RC.
Source: https://github.com/anki-code/xontrib-rc-awesome
If you like the idea click ⭐ on the repo and stay tuned. 
""" 

# ------------------------------------------------------------------------------
# xonshrc
# ------------------------------------------------------------------------------
# First of all please read official xonshrc doc - https://xon.sh/xonshrc.html
# This awesome rc file was written as an example to apply in `~/.xonshrc` run control 
# file that executed only when xonsh is in interactive mode i.e.:
#  * `xonsh` - interactive mode with executing `~/.xonshrc` before.
#  * `xonsh file.xsh` - non-interactive running without executing the `~/.xonshr` before.
# So if your want to put your run control file to another place use `$XONSH_INTERACTIVE`
# to check the mode.

# ------------------------------------------------------------------------------
# Temporary fixes of known issues
# ------------------------------------------------------------------------------

# https://github.com/prompt-toolkit/python-prompt-toolkit/issues/1696
__import__('warnings').filterwarnings('ignore', 'There is no current event loop', DeprecationWarning, 'prompt_toolkit')

# ------------------------------------------------------------------------------
# Imports
# It's a good practice to keep xonsh session cleano and add `_` alias for import.
# ------------------------------------------------------------------------------

import time as _time
from shutil import which as _which
from xonsh.platform import ON_LINUX, ON_DARWIN #, ON_WINDOWS, ON_WSL, ON_CYGWIN, ON_MSYS, ON_POSIX, ON_FREEBSD, ON_DRAGONFLY, ON_NETBSD, ON_OPENBSD


# ------------------------------------------------------------------------------
# Cross platform, for interactive and non-interactive modes.
# ------------------------------------------------------------------------------

# Sugar shortcut for __xonsh__
# Examples: 
#    X.last.rtn                                     # to get return code for the latest subprocess command.
#    with X.env.swap(VAR='val'): pass               # to set env context.
#    X.imp.json.loads('{"a":1}')                    # {'a': 1}
#    X.imp.datetime.datetime.now().isoformat()      # '2024-02-12T15:29:57.125696'
#    X.imp.hashlib.md5(b'Hello world').hexdigest()  # '3e25960a79dbc69b674cd4ec67a72c62'
X = __xonsh__


# Additional sugar: callable environment variable. Try `echo $dt`.
# See also - https://github.com/anki-code/xonsh-cheatsheet/blob/main/README.md#transparent-callable-environment-variables
$dt = type('TimeCl', (object,), {'__repr__':lambda self: X.imp.datetime.datetime.now().isoformat() })()


# Switch subprocess output to lines (xonsh >= 0.17.0) to have an ability to run commands like `du $(ls)`.
# Note! Downstream tools can produce errors after this so wrap the loading of them into 
# ```
# with X.env.swap(XONSH_SUBPROC_OUTPUT_FORMAT='stream_lines'):
#     # load conda
# ```
#
# $XONSH_SUBPROC_OUTPUT_FORMAT = 'list_lines'

# Environment switchers:
# aliases['xlines'] = "$XONSH_SUBPROC_OUTPUT_FORMAT = 'list_lines'; echo $XONSH_SUBPROC_OUTPUT_FORMAT"
# aliases['xstream'] = "$XONSH_SUBPROC_OUTPUT_FORMAT = 'stream_lines'; echo $XONSH_SUBPROC_OUTPUT_FORMAT"

if ON_LINUX or ON_DARWIN:
    # Add default bin paths.
    for p in [p'/home/linuxbrew/.linuxbrew/bin', p'~/.local/bin'.expanduser(), p'/opt/homebrew/opt/coreutils/libexec/gnubin']:
        if p.exists():
            $PATH.append(str(p))  # or `$PATH.prepend()`


if $XONSH_INTERACTIVE:
    
    if X.env.get('XONTRIB_RC_AWESOME_SHELL_TYPE_CHECK', True) and $SHELL_TYPE not in ['prompt_toolkit', 'none', 'best']:
        printx("{YELLOW}xontrib-rc-awesome: We recommend to use prompt_toolkit shell by installing `xonsh[full]` package.{RESET}")
    
    # First of all replace `$` to `@` in the prompt to not to be confused with another shell.
    # It will be good to read 
    #  - https://github.com/anki-code/xonsh-cheatsheet#three-most-frequent-things-that-newcomers-missed
    #  - https://github.com/xonsh/xonsh/issues/4152#issue-823993141
    $PROMPT_FIELDS['prompt_end'] = '@'

    # Add xontrib-cmd-durations to right prompt.
    # $RIGHT_PROMPT = '{long_cmd_duration}'

    # The SQLite history backend:
    # * Saves command immediately unlike JSON backend.
    # * Allows to do `history pull` to get commands from another parallel session.
    $XONSH_HISTORY_BACKEND = 'sqlite'

    # What commands are saved to the history list. By default all commands are saved. 
    # * The option ‘ignoredups’ will not save the command if it matches the previous command.
    # * The option `erasedups` will remove all previous commands that matches and updates the command frequency. 
    #   The minus of `erasedups` is that the history of every session becomes unrepeatable 
    #   because it will have a lack of the command you repeat in another session.
    # Docs: https://xonsh.github.io/envvars.html#histcontrol
    $HISTCONTROL = 'ignoredups'
    
    # Set regex to avoid saving unwanted commands
    # Do not write the command to the history if it was ended by `###`
    $XONSH_HISTORY_IGNORE_REGEX = '.*(\\#\\#\\#\\s*)$'


    # Remove front dot in multiline input to make the code copy-pastable.
    # $MULTILINE_PROMPT = ' ' # no background
    $MULTILINE_PROMPT = '{BACKGROUND_#222222} {RESET}'
    
    # Enable mouse support in the prompt_toolkit shell.
    # This allows clicking for positioning the cursor or selecting a completion.
    # In some terminals however, this disables the ability to scroll back through the history of the terminal.
    # To scroll on macOS in iTerm2 press Option key and scroll on touchpad.
    if 'pycharm' not in __xonsh__.env.get('__CFBundleIdentifier', ''):
        $MOUSE_SUPPORT = True


    # Adding aliases from dict.
    aliases |= {
        # cd-ing shortcuts.
        '-': 'cd -',
        '..': 'cd ..',
        
        # update pip and xonsh
        'xonsh-update': 'xpip install -U pip && xpip install -U --force-reinstall git+https://github.com/xonsh/xonsh',
    }


    # Easy way to go back cd-ing.
    # Example: `,,` the same as `cd ../../`
    @aliases.register(",")
    @aliases.register(",,")
    @aliases.register(",,,")
    @aliases.register(",,,,")
    def _alias_supercomma():
        """Easy way to go back cd-ing."""
        cd @("../" * len($__ALIAS_NAME))


    # Alias to get Xonsh Context.
    # Read more: https://github.com/anki-code/xonsh-cheatsheet/blob/main/README.md#install-xonsh-with-package-and-environment-management-system
    @aliases.register("xc")
    def _alias_xc():
        """Get xonsh context."""    
        print('xpython:', X.imp.sys.executable, '#', $(xpython -V).strip())
        print('xpip:', $(which xpip).strip())  # xpip - xonsh's builtin to install packages in current session xonsh environment.
        print('')
        print('xonsh:', $(which xonsh))
        print('python:', $(which python), '#' ,$(python -V).strip())
        print('pip:', $(which pip))
        if _which('pytest'):
            print('pytest:', $(which pytest))
        print('')
        envs = ['CONDA_DEFAULT_ENV']
        for ev in envs:
            if (val := X.env.get(ev)):
                print(f'{ev}:', val)


    # Example of utilizing `xonsh.tools.chdir` to do git commit, git config, git pull and push at once.
    # Usage: git-sync ~/git/myrepo1 ~/git/myrepo2
    if _which('git'):
        @aliases.register('git-sync')
        def _git_sync(args):
            from xonsh.tools import chdir
            paths = args if args else [$PWD]
            for p in paths:
                print(f'git sync {p}')
                with chdir(p):
                    git config --local user.name $USER
                    git config --local user.email $USER@$USER.local
                    git commit --allow-empty -a -uno -m "Update"
                    git pull --rebase
                    git push


    # Avoid typing cd just directory path. 
    # Docs: https://xonsh.github.io/envvars.html#auto-cd
    $AUTO_CD = True

    #
    # Xontribs - https://github.com/topics/xontrib
    #
    # Note! Because of xonsh read ~/.xonshrc on every start and can be executed from any virtual environment 
    # with the different set of installed packages it's a highly recommended approach to use `-s` to avoid errors.
    # Read more: https://github.com/anki-code/xonsh-cheatsheet/blob/main/README.md#install-xonsh-with-package-and-environment-management-system
    #
    _xontribs_to_load = (
        'dalias',             # Library of decorator aliases (daliases) e.g. `$(@json echo '{}')`.
        'jump_to_dir',        # Jump to used before directory by part of the path. Lightweight zero-dependency implementation of autojump or zoxide projects functionality. 
        'prompt_bar',         # The bar prompt for xonsh shell with customizable sections. URL: https://github.com/anki-code/xontrib-prompt-bar
        'whole_word_jumping', # Jumping across whole words (non-whitespace) with Ctrl+Left/Right and Alt+Left/Right on Linux or Option+Left/Right on macOS.
        'back2dir',           # Back to the latest used directory when starting xonsh shell. URL: https://github.com/anki-code/xontrib-back2dir
        'pipeliner',          # Let your pipe lines flow thru the Python code. URL: https://github.com/anki-code/xontrib-pipeliner
        'cmd_done',           # Show long running commands durations in prompt with option to send notification when terminal is not focused. URL: https://github.com/jnoortheen/xontrib-cmd-durations
        'jedi',               # Jedi - an awesome autocompletion, static analysis and refactoring library for Python. URL: https://github.com/xonsh/xontrib-jedi
        'clp',                # Copy output to clipboard. URL: https://github.com/anki-code/xontrib-clp
    )
    xontrib load -s @(_xontribs_to_load)

    
    # ------------------------------------------------------------------------------
    # Conda (https://conda-forge.org/)
    # ------------------------------------------------------------------------------
    # To speed up startup you can disable auto activate the base environment.
    # $CONDA_AUTO_ACTIVATE_BASE = 'false'


if ON_LINUX or ON_DARWIN:
       
    # Globbing files with “*” or “**” will also match dotfiles, or those ‘hidden’ files whose names begin with a literal ‘.’. 
    # Note! This affects also on rsync and other tools.
    $DOTGLOB = True

    # Don't clear the screen after quitting a manual page.
    $MANPAGER = "less -X"
    $LESS = "--ignore-case --quit-if-one-screen --quit-on-intr FRXQ"

    # Flag for automatically pushing directories onto the directory stack i.e. `dirs -p` (https://xon.sh/aliases.html#dirs).
    # It's for `mc` alias (below).
    $AUTO_PUSHD = True


    # Adding aliases from dict.
    aliases |= {
        # Execute python that used to run current xonsh session.
        'xpython': X.imp.sys.executable,

        # List all files: sorted, with colors, directories will be first (Midnight Commander style).
        'll': "$LC_COLLATE='C' ls --group-directories-first -lAh --color @($args)",
        
        # Make directory and cd into it.
        # Example: md /tmp/my/awesome/dir/will/be/here
        'md': 'mkdir -p $arg0 && cd $arg0',
        
        # Grepping string occurrences recursively starting from current directory.
        # Example: cd ~/git/xonsh && greps environ
        'greps': 'grep -ri',

        # `grep` with color output.
        # This is distinct alias to keep output clean in case `var = $(echo 123 | grep 12)`
        'grepc': 'grep --color=always',
    
        # SSH: Suppress "Connection close" message.
        'ssh': 'ssh -o LogLevel=QUIET',

        # Run http server in the current directory.
        'http-here': 'python3 -m http.server',
    }
    
    # Run Midnight Commander where left and right panel will be the current and the previous directory.
    # Required: $AUTO_PUSHD = True
    if _which('mc'):
        aliases['mc'] = "mc @($PWD if not $args else $args) @($OLDPWD if not $args else $PWD)"

    # Using rsync instead of cp to get the progress and speed of copying.
    if _which('rsync'):
        aliases['cp'] = 'rsync --progress --recursive --archive'
        
    # myip - get my external IP address
    if _which('curl'):
        aliases['myip'] = 'curl @($args) -s https://ifconfig.co/json' + (' | jq' if _which('jq') else '')
    
    # OpenAI model to translate text to code.
    # Example:
    #     ```
    #     ai! give me the small json in one line
    #     # {"name":"John","age":30,"city":"New York"}
    #     ```
    if _which('openai'):
        $OPENAI_API_KEY = 'abcde1234'  # https://platform.openai.com/account/api-keys
        aliases['ai'] = "openai api completions.create -m text-davinci-003 -t 0 -M 500 --stream -p @(' '.join($args))"
    
    if _which('screen'):
        # `screen-run` alias to run command in screen session.
        @aliases.register("screen-run")
        def __screen_run(args):
            from datetime import datetime as _datetime
            screen_name = "s" + _datetime.now().strftime("%S%M%H")  # This screen name is more unique to run `screen -r <name>`
            screen_cmd = " ".join(args)
            print('Start session', screen_name, ':', screen_cmd)
            screen -S @(screen_name)  xonsh -c @(screen_cmd + '; echo Done; exec xonsh')
            screen -ls
    #
    # Xontribs - https://github.com/topics/xontrib
    #
    # Note! Because of xonsh read ~/.xonshrc on every start and can be executed from any virtual environment 
    # with the different set of installed packages it's a highly recommended approach to use `-s` to avoid errors.
    # Read more: https://github.com/anki-code/xonsh-cheatsheet/blob/main/README.md#install-xonsh-with-package-and-environment-management-system
    #
    _xontribs_to_load = (
        'sh',                # Paste and run commands from bash, zsh, fish, tcsh in xonsh shell. URL: https://github.com/anki-code/xontrib-sh
        #'output_search',    # Get words from the previous command output for the next command. URL: https://github.com/tokenizer/xontrib-output-search
    )
    xontrib load -s @(_xontribs_to_load)
    
    if False:
        # Example of how to check the operating system and install xontrib from git.
        if ON_LINUX and _which('lsb_release') and 'Ubuntu' in $(lsb_release --id --release --short):
            xpip install git+https://github.com/DangerOnTheRanger/xonsh-apt-tabcomplete
            xontrib load apt_tabcomplete

            
    # Example of history search alias for sqlite history backend.
    # You can use it ordinarily: `hs "cd /"`.
    # Or as a macro call: `hs! cd /`.
    aliases |= {
        # history search
        'hs': """sqlite3 $XONSH_HISTORY_FILE @("SELECT inp FROM xonsh_history WHERE inp LIKE '%" + $arg0 + "%' AND inp NOT LIKE 'history-%' ORDER BY tsb DESC LIMIT 10");""",
        # history in dir
        'hd': """sqlite3 $XONSH_HISTORY_FILE @(f"SELECT inp FROM xonsh_history WHERE cwd LIKE '%{$PWD}%' AND inp NOT LIKE 'history-%' ORDER BY tsb DESC LIMIT 10");""",
    }
    
    #
    # Example of binding the hotkeys - https://xon.sh/tutorial_ptk.html
    # List of keys - https://github.com/prompt-toolkit/python-prompt-toolkit/blob/master/src/prompt_toolkit/keys.py
    # `event.current_buffer` - https://python-prompt-toolkit.readthedocs.io/en/stable/pages/reference.html#prompt_toolkit.buffer.Buffer
    #
    
    from prompt_toolkit.keys import Keys

    @events.on_ptk_create
    def custom_keybindings(bindings, **kw):

        # Press F1 and get the list of files
        @bindings.add(Keys.F1)
        def run_ls(event):
            ls -l
            event.cli.renderer.erase()

        # Press F3 to insert the grep command
        @bindings.add(Keys.F3)
        def add_grep(event):
            event.current_buffer.insert_text(' | grep -i ')     

        # Clear line by pressing `Escape` key
        @bindings.add("escape")
        def clear_line(event):
            event.current_buffer.delete_before_cursor(1000)


    #
    # Example of customizing the output: comma separated thousands in output.
    # Input: `1000+10000`.
    # Output: `11,000`.
    #    
    import xonsh.pretty
    xonsh.pretty.for_type(type(1), lambda int, printer, cycle: printer.text(f'{int:,}'))
    xonsh.pretty.for_type(type(1.0), lambda float, printer, cycle: printer.text(f'{float:,}'))

    #
    # For the experienced users:
    #

    # Suppress line "xonsh: For full traceback set: $XONSH_SHOW_TRACEBACK = True".
    # in case of exceptions or wrong command.
    $XONSH_SHOW_TRACEBACK = False
    
    # Suppress line "Did you mean one of the following?".
    $SUGGEST_COMMANDS = False


# Thanks for reading! PR is welcome!
