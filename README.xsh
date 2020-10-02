"""

Awesome snippets code to make .xonshrc better.
If you like the idea click ⭐ on the repo and stay tuned. 

Install awesome xonshrc:

    curl -s https://raw.githubusercontent.com/anki-code/awesome-xonshrc/main/README.xsh > ~/.xonshrc


,adPPYYba,  8b      db      d8   ,adPPYba,  ,adPPYba,   ,adPPYba,   88,dPYba,,adPYba,    ,adPPYba,  
""     `Y8  `8b    d88b    d8'  a8P     88  I8[    ""  a8"     "8a  88P'   "88"    "8a  a8P     88  
,adPPPPP88   `8b  d8'`8b  d8'   8PP"""""""   `"Y8ba,   8b       d8  88      88      88  8PP"""""""  
88,    ,88    `8bd8'  `8bd8'    "8b,   ,aa  aa    ]8I  "8a,   ,a8"  88      88      88  "8b,   ,aa  
`"8bbdP"Y8      YP      YP       `"Ybbd8"'  `"YbbdP"'   `"YbbdP"'   88      88      88   `"Ybbd8"'  
                                                                                                    
                                             
                                                     88                                             
                                                     88                                             
    8b,     ,d8  ,adPPYba,   8b,dPPYba,   ,adPPYba,  88,dPPYba,   8b,dPPYba,   ,adPPYba,            
     `Y8, ,8P'  a8"     "8a  88P'   `"8a  I8[    ""  88P'    "8a  88P'   "Y8  a8"     ""            
       )888(    8b       d8  88       88   `"Y8ba,   88       88  88          8b                    
     ,d8" "8b,  "8a,   ,a8"  88       88  aa    ]8I  88       88  88          "8a,   ,aa            
    8P'     `Y8  `"YbbdP"'   88       88  `"YbbdP"'  88       88  88           `"Ybbd8"'            

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
