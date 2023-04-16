<p align="center">
Awesome snippets of code for xonshrc in xonsh shell. 
</p>

<p align="center">
If you like the idea click ⭐ on the repo and <a href="https://twitter.com/intent/tweet?text=The%20xonsh%20shell%20awesome%20rc%20file!&url=https://github.com/anki-code/awesome-xonshrc" target="_blank">tweet</a>.
</p>

### Use cases

#### Create your own pip-installable RC based on the awesome xonsh RC

1. Fork this repository
2. Rename the repository to `xontrib-rc-yourname`
3. Change the name [in setup.py](https://github.com/anki-code/xontrib-rc-awesome/blob/e21370c1155262b8e25bd354cb4d4f9f15945384/setup.py#L11)
4. Change the name of `xontrib/rc_awesome.xsh` to `xontrib/rc_yourname.xsh`
5. [Add xontribs you need to setup.py](https://github.com/anki-code/xontrib-rc-awesome/blob/495dce4c8e7e8c9882ea002db60935d03f3fb861/setup.py#L20-L38) (the xontribs will be installed automatically during `pip install`)
6. Now you can just run anywhere:
    ```xonsh
    pip install -U git+https://github.com/yourname/xontrib-rc-yourname
    echo 'xontrib load rc_yourname' >> ~/.xonshrc  # To avoid this create autoloadable xontrib using xontrib-template
    xonsh
    ```
    Also you can avoid manual loading the xontrib in `~/.xonshrc` by creating autoloadable xontrib using [xontrib-template](https://github.com/xonsh/xontrib-template). Answer yes on the question about enabling autoloading.
    
7. [Increment version](https://github.com/anki-code/xontrib-rc-awesome/blob/df5c0aa3e29325f5d926cec7022cd2ccc184c0c5/setup.py#L12) to update the package using `pip install -U git+https://github.com/yourname/xontrib-rc-yourname`

#### Copy and paste

Just read [rc_awesome](https://github.com/anki-code/xontrib-rc-awesome/blob/main/xontrib/rc_awesome.xsh) and copy the snippets to your xonsh RC.

Or add awesome xonsh RC to the end of your xonshrc:
```
curl -s https://raw.githubusercontent.com/anki-code/xontrib-rc-awesome/main/xontrib/rc_awesome.xsh >> ~/.xonshrc
```

Or install awesome [xonsh RC as a package](https://github.com/anki-code/xontrib-rc-awesome/blob/fabe895fbdd89f7bd3050bf492aa0665624a9705/setup.py#L10-L16) with [automatically installable xontribs](https://github.com/anki-code/xontrib-rc-awesome/blob/fabe895fbdd89f7bd3050bf492aa0665624a9705/setup.py#L20-L30):
```xonsh
pip install -U git+https://github.com/anki-code/xontrib-rc-awesome
echo 'xontrib load rc_awesome' >> ~/.xonshrc
xonsh
```

#### Learn from xonsh RC gurus

* [Anthony Scopatz RC](https://github.com/xonsh/xonsh/pull/3917#issuecomment-715649009) (click Details to see the xonshrc)
* [Sean Farley RC](https://github.com/seanfarley/dotfiles/blob/c87811f50cd696a8d4ddce83c1ca295a00b70218/xonshrc)
* [Gyuri Horak RC](https://github.com/dyuri/rcfiles/blob/master/.xonshrc)
* [Alexander Sosedkin RC](https://github.com/t184256/nix-configs/tree/main/user/xonsh/config)
* [Noorhteen Raja NJ RC](https://github.com/jnoortheen/xonfig)
* [Ryan Delaney RC](https://github.com/rpdelaney/dotfiles/tree/main/home/.config/xonsh)

### See also
* [xonsh-cheatsheet](https://github.com/anki-code/xonsh-cheatsheet/blob/main/README.md) - cheat sheet for xonsh shell with copy-pastable examples.
* [xontrib-template](https://github.com/xonsh/xontrib-template) - Full-featured template for building extension (xontrib) for the xonsh shell.
