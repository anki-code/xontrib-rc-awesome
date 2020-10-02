"""
Awesome snippets code to make .xonshrc better.
If you like the idea click ⭐ on the repo and stay tuned. 

Install awesome xonshrc:

    curl -s https://raw.githubusercontent.com/anki-code/awesome-xonshrc/main/README.xsh > ~/.xonshrc
    
""" 

# cd-ing shortcuts
aliases['-'] = 'cd -'
aliases['..'] = 'cd ..'

# Avoid typing cd just directory path
$AUTO_CD = True

# Don't clear the screen after quitting a manual page
$MANPAGER = "less -X"
$LESS = "--ignore-case --quit-if-one-screen --quit-on-intr FRXQ"

# SSH: Suppress "Connection close" message
aliases['ssh']='ssh -o LogLevel=QUIET'

# Acknowledgments:
"""
Sean Farley xonshrc - https://github.com/seanfarley/dotfiles/blob/master/xonshrc
"""
