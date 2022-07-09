"""
Awesome snippets code to make .xonshrc better - https://github.com/anki-code/xontrib-rc-awesome
If you like the idea click ⭐ on the repo and stay tuned. 
""" 

# -------------------------------------------------------------------------------------------------------------------------------------------------------------
# Cross platform
# -------------------------------------------------------------------------------------------------------------------------------------------------------------

# The SQLite history backend saves command immediately 
# unlike JSON backend that save the commands at the end of the session.
$XONSH_HISTORY_BACKEND = 'sqlite'

# What commands are saved to the history list. By default all commands are saved. 
# * The option ‘ignoredups’ will not save the command if it matches the previous command.
# * The option `erasedups` will remove all previous commands that matches and updates the command frequency. 
#   The minus of `erasedups` is that the history of every session becomes unrepeatable 
#   because it will have a lack of the command you repeat in another session.
# Docs: https://xonsh.github.io/envvars.html#histcontrol
$HISTCONTROL='ignoredups'


# Remove front dot in multiline input to make the code copy-pastable.
$MULTILINE_PROMPT=' '


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
_xontribs = [
    'whole_word_jumping', # Jumping across whole words (non-whitespace) with Ctrl + Left/Right and Alt + Left/Right.
]
if _xontribs:
    xontrib load @(_xontribs)


# -------------------------------------------------------------------------------------------------------------------------------------------------------------
# Platform specific
# -------------------------------------------------------------------------------------------------------------------------------------------------------------

from xonsh.platform import ON_LINUX, ON_DARWIN  #, ON_WINDOWS, ON_WSL, ON_CYGWIN, ON_MSYS, ON_POSIX, ON_FREEBSD, ON_DRAGONFLY, ON_NETBSD, ON_OPENBSD

if ON_LINUX or ON_DARWIN:
    
    # Globbing files with “*” or “**” will also match dotfiles, or those ‘hidden’ files whose names begin with a literal ‘.’. 
    # Note! This affects also on rsync and other tools.
    $DOTGLOB = True

    # Don't clear the screen after quitting a manual page.
    $MANPAGER = "less -X"
    $LESS = "--ignore-case --quit-if-one-screen --quit-on-intr FRXQ"

    # Flag for automatically pushing directories onto the directory stack.
    # It's for `mc` alias (below).
    $AUTO_PUSHD = True

    # List all files: sorted, with colors, directories will be first (Midnight Commander style).
    aliases['ll'] = "$LC_COLLATE='C' ls --group-directories-first -lAh --color @($args)"

    # Run Midnight Commander where left and right panel will be the current and the previous directory.
    # Required: $AUTO_PUSHD = True
    aliases['mc'] = "mc @($PWD if not $args else $args) @($OLDPWD if not $args else $PWD)"

    # Make directory and cd into it.
    # Example: md /tmp/my/awesome/dir/will/be/here
    aliases['md'] = 'mkdir -p $arg0 && cd $arg0'
        
    # Using rsync instead of cp to get the progress and speed of copying.
    aliases['cp'] = ['rsync', '--progress', '--recursive', '--archive']
    
    # Grepping string occurrences recursively starting from current directory.
    # Example: cd ~/git/xonsh && greps environ
    aliases['greps'] = 'grep -ri'

    # Copy output to current clipboard using xclip.
    # Example: echo hello | clp
    aliases['clp'] = 'pbcopy' if ON_DARWIN else 'xclip -sel clip'    

    # SSH: Suppress "Connection close" message.
    aliases['ssh'] = 'ssh -o LogLevel=QUIET'

    # Run http server in the current directory.
    aliases['http-here'] = 'python3 -m http.server'

    # The example of alias that calls the command with arguments
    aliases['docker-exec-bash'] = lambda args: $[docker exec -it @(args) bash]
    
    
    #
    # Xontribs - https://github.com/topics/xontrib
    #
    _xontribs = [
        'back2dir',          # Back to the latest used directory when starting xonsh shell. URL: https://github.com/anki-code/xontrib-back2dir
        'prompt_bar',       # The bar prompt for xonsh shell with customizable sections. URL: https://github.com/anki-code/xontrib-prompt-bar
        'pipeliner',        # Let your pipe lines flow thru the Python code. URL: https://github.com/anki-code/xontrib-pipeliner
        'sh',               # Paste and run commands from bash, zsh, fish, tcsh in xonsh shell. URL: https://github.com/anki-code/xontrib-sh
        #'output_search',    # Get words from the previous command output for the next command. URL: https://github.com/tokenizer/xontrib-output-search
    ]
    if _xontribs:
        xontrib load @(_xontribs)

    if $(which lsb_release):
        if 'Ubuntu' in $(lsb_release --id --release --short).strip():
            xontrib load apt_tabcomplete
        
