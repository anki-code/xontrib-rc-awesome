<p align="center">
Awesome snippets of code for xonshrc in xonsh shell. 
</p>

<p align="center">
If you like the idea click ⭐ on the repo and <a href="https://twitter.com/intent/tweet?text=The%20xonsh%20shell%20awesome%20rc%20file!&url=https://github.com/anki-code/awesome-xonshrc" target="_blank">tweet</a>.
</p>

### Install and try basic rc_awesome

```xonsh
pip install -U git+https://github.com/anki-code/xontrib-rc-awesome
echo 'xontrib load rc_awesome' >> ~/.xonshrc
xonsh
```

### Use cases

#### The simple way: just read

Just read [rc_awesome](https://github.com/anki-code/xontrib-rc-awesome/blob/main/xontrib/rc_awesome.xsh) and copy the snippets to your RC. 

Also interesting xonsh RC files from xonsh gurus:
* [Anthony Scopatz RC](https://github.com/xonsh/xonsh/pull/3917#issuecomment-715649009) (click Details to see the xonshrc)
* [Sean Farley RC](https://github.com/seanfarley/dotfiles/blob/c87811f50cd696a8d4ddce83c1ca295a00b70218/xonshrc)
* [Gyuri Horak RC](https://github.com/dyuri/rcfiles/blob/master/.xonshrc)
* [Alexander Sosedkin RC](https://github.com/t184256/nix-configs/tree/main/user/xonsh/config)
* [Noorhteen Raja NJ RC](https://github.com/jnoortheen/xonfig)

#### The master way: create your own RC based on this repo:

1. Fork this repository
2. Rename the repository to `xontrib-rc-yourname` and change the name [in setup.py](https://github.com/anki-code/xontrib-rc-awesome/blob/e21370c1155262b8e25bd354cb4d4f9f15945384/setup.py#L11). Also change the name of `xontrib/rc_awesome.xsh` to `rc_yourname.xsh`
3. [Add xontribs you need to setup.py](https://github.com/anki-code/xontrib-rc-awesome/blob/e21370c1155262b8e25bd354cb4d4f9f15945384/setup.py#L20-L28)
4. Now you can just run anywhere:
    ```xonsh
    pip install -U git+https://github.com/yourname/xontrib-rc-yourname
    echo 'xontrib load rc_yourname' >> ~/.xonshrc
    xonsh
    ```

### See also
* [xonsh-cheatsheet](https://github.com/anki-code/xonsh-cheatsheet/blob/main/README.md) - cheat sheet for xonsh shell with copy-pastable examples.
