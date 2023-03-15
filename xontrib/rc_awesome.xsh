"""
Awesome snippets of code to make your awesome xonsh RC.
Source: https://github.com/anki-code/xontrib-rc-awesome
If you like the idea click ⭐ on the repo and stay tuned. 
""" 

# ------------------------------------------------------------------------------
# Temporary fixes of known issues
# ------------------------------------------------------------------------------

# https://github.com/prompt-toolkit/python-prompt-toolkit/issues/1696
__import__('warnings').filterwarnings('ignore', 'There is no current event loop', DeprecationWarning, 'prompt_toolkit.eventloop.utils')

# ------------------------------------------------------------------------------
# Imports
# It's a good practice to keep xonsh session cleano and add _ alias for import
# ------------------------------------------------------------------------------

from shutil import which as _which
import time as _time

# ------------------------------------------------------------------------------
# Cross platform
# ------------------------------------------------------------------------------

if __xonsh__.env.get('XONTRIB_RC_AWESOME_SHELL_TYPE_CHECK', True) and $SHELL_TYPE not in ['prompt_toolkit', 'none', 'best']:
    printx("{YELLOW}xontrib-rc-awesome: We recommend to use prompt_toolkit shell by installing `xonsh[full]` package.{RESET}")

# First of all replace `$` to `@` in the prompt to not to be confused with another shell.
# It will be good to read 
#  - https://github.com/anki-code/xonsh-cheatsheet#three-most-frequent-things-that-newcomers-missed
#  - https://github.com/xonsh/xonsh/issues/4152#issue-823993141
$PROMPT_FIELDS['prompt_end'] = '@'

# Add xontrib-cmd-durations to right prompt
$RIGHT_PROMPT = '{long_cmd_duration}'

# The SQLite history backend saves command immediately 
# unlike JSON backend that save the commands at the end of the session.
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
$MULTILINE_PROMPT = ' '

# Enable mouse support in the prompt_toolkit shell.
# This allows clicking for positioning the cursor or selecting a completion.
# In some terminals however, this disables the ability to scroll back through the history of the terminal.
# To scroll on macOS in iTerm2 press Option key and scroll on touchpad.
$MOUSE_SUPPORT = True


# cd-ing shortcuts.
aliases['-'] = 'cd -'
aliases['..'] = 'cd ..'
aliases['....'] = 'cd ../..'


# Avoid typing cd just directory path. 
# Docs: https://xonsh.github.io/envvars.html#auto-cd
$AUTO_CD = True

#
# Xontribs - https://github.com/topics/xontrib
#
# Note! Because of xonsh read ~/.xonshrc on every start and can be executed from any virtual environment 
# with the different set of installed packages it's a highly recommended approach to check 
# the list of the xontribs before loading to avoid errors.
#
# Read: https://github.com/anki-code/xonsh-cheatsheet/blob/main/README.md#install-xonsh-with-package-and-environment-management-system
# Vote to simplify loading: https://github.com/xonsh/xonsh/issues/5023
#
# TODO: reduce this code after merging https://github.com/xonsh/xonsh/pull/5028
#
from xonsh.xontribs import get_xontribs
_xontribs_installed = set(get_xontribs().keys())

_xontribs_to_load = (
    'whole_word_jumping', # Jumping across whole words (non-whitespace) with Ctrl+Left/Right and Alt+Left/Right on Linux or Option+Left/Right on macOS.
    'back2dir',           # Back to the latest used directory when starting xonsh shell. URL: https://github.com/anki-code/xontrib-back2dir
    'prompt_bar',         # The bar prompt for xonsh shell with customizable sections. URL: https://github.com/anki-code/xontrib-prompt-bar
    'pipeliner',          # Let your pipe lines flow thru the Python code. URL: https://github.com/anki-code/xontrib-pipeliner
    'cmd_done',           # Show long running commands durations in prompt with option to send notification when terminal is not focused. URL: https://github.com/jnoortheen/xontrib-cmd-durations
    'jedi',               # Jedi - an awesome autocompletion, static analysis and refactoring library for Python. URL: https://github.com/xonsh/xontrib-jedi
    'jump_to_dir',        # Jump to used before directory by part of the path. Lightweight zero-dependency implementation of autojump or zoxide projects functionality. 
    'clp',                # Copy output to clipboard. URL: https://github.com/anki-code/xontrib-clp
)
xontrib load @(_xontribs_installed.intersection(_xontribs_to_load))


# ------------------------------------------------------------------------------
# Platform specific
# ------------------------------------------------------------------------------

from xonsh.platform import ON_LINUX, ON_DARWIN #, ON_WINDOWS, ON_WSL, ON_CYGWIN, ON_MSYS, ON_POSIX, ON_FREEBSD, ON_DRAGONFLY, ON_NETBSD, ON_OPENBSD

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

    # Add default bin paths
    for p in [p'/home/linuxbrew/.linuxbrew/bin', fp'/home/{$USER}/.local/bin', p'/opt/homebrew/opt/coreutils/libexec/gnubin']:
        if p.exists():
            $PATH.append(str(p))
    
    
    # List all files: sorted, with colors, directories will be first (Midnight Commander style).
    aliases['ll'] = "$LC_COLLATE='C' ls --group-directories-first -lAh --color @($args)"

    # Run Midnight Commander where left and right panel will be the current and the previous directory.
    # Required: $AUTO_PUSHD = True
    if _which('mc'):
        aliases['mc'] = "mc @($PWD if not $args else $args) @($OLDPWD if not $args else $PWD)"

    # Make directory and cd into it.
    # Example: md /tmp/my/awesome/dir/will/be/here
    aliases['md'] = 'mkdir -p $arg0 && cd $arg0'
        
    # Using rsync instead of cp to get the progress and speed of copying.
    if _which('rsync'):
        aliases['cp'] = 'rsync --progress --recursive --archive'
    
    # `grep` with color output.
    # This is distinct alias to keep output clean in case `var = $(echo 123 | grep 12)`
    aliases['grepc'] = 'grep --color=always'
    
    # Grepping string occurrences recursively starting from current directory.
    # Example: cd ~/git/xonsh && greps environ
    aliases['greps'] = 'grep -ri'

    # SSH: Suppress "Connection close" message.
    aliases['ssh'] = 'ssh -o LogLevel=QUIET'

    # Run http server in the current directory.
    aliases['http-here'] = 'python3 -m http.server'

    # myip - get my external IP address
    if _which('curl'):
        aliases['myip'] = 'curl @($args) -s https://ifconfig.co/json' + (' | jq' if _which('jq') '')
    
    if _which('screen'):
        # `screen-run` alias to run command in screen session
        def _screen_run(args):
            from datetime import datetime as _datetime
            screen_name = "s" + _datetime.now().strftime("%S%M%H")  # This screen name is more unique to run `screen -r <name>`
            screen_cmd = " ".join(args)
            print('Start session', screen_name, ':', screen_cmd)
            screen -S @(screen_name)  xonsh -c @(screen_cmd + '; echo Done; exec xonsh')
            screen -ls
        aliases['screen-run'] = _screen_run
        del _screen_run
        
    
    #
    # Xontribs - https://github.com/topics/xontrib
    #
    # Note! Because of xonsh read ~/.xonshrc on every start and can be executed from any virtual environment 
    # with the different set of installed packages it's a highly recommended approach to check 
    # the list of the xontribs before loading to avoid errors.
    #
    # Read: https://github.com/anki-code/xonsh-cheatsheet/blob/main/README.md#install-xonsh-with-package-and-environment-management-system
    # Vote to simplify loading: https://github.com/xonsh/xonsh/issues/5023
    #
    _xontribs_to_load = (
        'sh',                # Paste and run commands from bash, zsh, fish, tcsh in xonsh shell. URL: https://github.com/anki-code/xontrib-sh
        #'output_search',    # Get words from the previous command output for the next command. URL: https://github.com/tokenizer/xontrib-output-search
    )
    xontrib load @(_xontribs_installed.intersection(_xontribs_to_load))
    
    if False: # Example of how to check the operating system
        if ON_LINUX and 'apt_tabcomplete' in _xontribs_installed and shutil.which('lsb_release'):
            if 'Ubuntu' in $(lsb_release --id --release --short).strip():
                xontrib load apt_tabcomplete

            
    # Example of history search alias for sqlite history backend
    # You can use it ordinarily: `history-search "cd /"`
    # Or as a macro call: `history-search! cd /`
    aliases['history-search'] = """sqlite3 $XONSH_HISTORY_FILE @("SELECT inp FROM xonsh_history WHERE inp LIKE '%" + $arg0 + "%' AND inp NOT LIKE 'history-%' ORDER BY tsb DESC LIMIT 10");"""

    
    #
    # Example of binding the hotkeys - https://xon.sh/tutorial_ptk.html
    # List of keys - https://github.com/prompt-toolkit/python-prompt-toolkit/blob/master/src/prompt_toolkit/keys.py
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
        def say_hi(event):
            event.current_buffer.insert_text(' | grep -i ')            


    #
    # Example of customizing the output: comma separated thousands in output
    # Input: 1000+10000
    # Output: 11,000
    #    
    import xonsh.pretty
    xonsh.pretty.for_type(type(1), lambda int, printer, cycle: printer.text(f'{int:,}'))
    xonsh.pretty.for_type(type(1.0), lambda float, printer, cycle: printer.text(f'{float:,}'))
          
# ------------------------------------------------------------------------------
# Final
# ------------------------------------------------------------------------------
        
# For the experienced users

# Suppress line "xonsh: For full traceback set: $XONSH_SHOW_TRACEBACK = True" 
# in case of exceptions or wrong command.
$XONSH_SHOW_TRACEBACK = False

# Suppress line "Did you mean one of the following?"
$SUGGEST_COMMANDS = False
    
   
