<p align="center">
Awesome snippets code to make <code>.xonshrc</code> better.
</p>

<p align="center">  
If you like the idea of xxh click ⭐ on the repo and stay tuned.
</p>

#### cd-ing shortcuts
```python
aliases['-'] = 'cd -'
aliases['..'] = 'cd ..'
```

#### Avoid typing cd
```python
$AUTO_CD = True
```

#### Don't clear the screen after quitting a manual page 
```python
$MANPAGER = "less -X"
$LESS = "--ignore-case --quit-if-one-screen --quit-on-intr FRXQ"
```


#### SSH: Suppress "Connection close" message
```python
aliases['ssh']='ssh -o LogLevel=QUIET'
```
