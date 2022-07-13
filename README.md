<p align="center">
Awesome snippets of code for xonshrc in xonsh shell. 
</p>

<p align="center">
If you like the idea click ⭐ on the repo and <a href="https://twitter.com/intent/tweet?text=The%20xonsh%20shell%20awesome%20rc%20file!&url=https://github.com/anki-code/awesome-xonshrc" target="_blank">tweet</a>.
</p>

### Use cases

#### Copy and paste

Just read [rc_awesome](https://github.com/anki-code/xontrib-rc-awesome/blob/main/xontrib/rc_awesome.xsh) and copy the snippets to your xonsh RC.

Or add awesome xonsh RC to the end of your xonshrc:
```
curl -s https://raw.githubusercontent.com/anki-code/xontrib-rc-awesome/main/xontrib/rc_awesome.xsh >> ~/.xonshrc
```

#### Learn from xonsh RC gurus

Also interesting xonsh RC files from xonsh gurus:
* [Anthony Scopatz RC](https://github.com/xonsh/xonsh/pull/3917#issuecomment-715649009) (click Details to see the xonshrc)
* [Sean Farley RC](https://github.com/seanfarley/dotfiles/blob/c87811f50cd696a8d4ddce83c1ca295a00b70218/xonshrc)
* [Gyuri Horak RC](https://github.com/dyuri/rcfiles/blob/master/.xonshrc)
* [Alexander Sosedkin RC](https://github.com/t184256/nix-configs/tree/main/user/xonsh/config)
* [Noorhteen Raja NJ RC](https://github.com/jnoortheen/xonfig)
* [Ryan Delaney RC](https://github.com/rpdelaney/dotfiles/tree/main/home/.config/xonsh)

#### Try awesome xonsh RC in action:

```xonsh
pip install -U git+https://github.com/anki-code/xontrib-rc-awesome
echo 'xontrib load rc_awesome' >> ~/.xonshrc
xonsh
```

#### Create your own installable RC based on the awesome xonsh RC

1. Fork this repository or use it as [template](https://docs.github.com/articles/creating-a-repository-from-a-template/)
2. Rename the repository to `xontrib-rc-yourname`
3. Change the name [in setup.py](https://github.com/anki-code/xontrib-rc-awesome/blob/e21370c1155262b8e25bd354cb4d4f9f15945384/setup.py#L11)
4. Change the name of `xontrib/rc_awesome.xsh` to `xontrib/rc_yourname.xsh`
5. [Add xontribs you need to setup.py](https://github.com/anki-code/xontrib-rc-awesome/blob/e21370c1155262b8e25bd354cb4d4f9f15945384/setup.py#L20-L28) (the xontribs will be installed automatically during `pip install`)
6. Now you can just run anywhere:
    ```xonsh
    pip install -U git+https://github.com/yourname/xontrib-rc-yourname
    echo 'xontrib load rc_yourname' >> ~/.xonshrc
    xonsh
    ```
7. [Increment version](https://github.com/anki-code/xontrib-rc-awesome/blob/df5c0aa3e29325f5d926cec7022cd2ccc184c0c5/setup.py#L12) to update the package using `pip install -U git+https://github.com/yourname/xontrib-rc-yourname`

### See also
* [xonsh-cheatsheet](https://github.com/anki-code/xonsh-cheatsheet/blob/main/README.md) - cheat sheet for xonsh shell with copy-pastable examples.
