# Level 0 - 1

The goal of this level is for you to log into the game using SSH. The host to which you need to connect is bandit.labs.overthewire.org, on port 2220. The username is bandit0 and the password is bandit0. Once logged in, go to the Level 1 page to find out how to beat Level 1.

```
> sshpass -p "bandit0" ssh bandit0@bandit.labs.overthewire.org -p 2220 cat readme
This is a OverTheWire game server. More information on http://www.overthewire.org/wargames

boJ9jbbUNNfktd78OOpsqOltutMc3MY1
```

# Level 1 - 2

The password for the next level is stored in a file called - located in the home directory

```
sshpass -p "boJ9jbbUNNfktd78OOpsqOltutMc3MY1" ssh bandit1@bandit.labs.overthewire.org -p 2220 cat ./-
```

# Level 2 - 3

The password for the next level is stored in a file called spaces in this filename located in the home directory

```
bandit2@bandit:~$ cat spaces\ in\ this\ filename
UmHadQclWmgdLOKQ3YNgjWxGoRMb5luK
```

# Level 3 - 4

The password for the next level is stored in a hidden file in the inhere directory

```
bandit3@bandit:~$ ls
inhere
bandit3@bandit:~$ cd inhere
bandit3@bandit:~/inhere$ ls
bandit3@bandit:~/inhere$ ls -lah
total 12K
drwxr-xr-x 2 root    root    4.0K May  7  2020 .
drwxr-xr-x 3 root    root    4.0K May  7  2020 ..
-rw-r----- 1 bandit4 bandit3   33 May  7  2020 .hidden
bandit3@bandit:~/inhere$ cat .hidden
pIwrPrtPN36QITSp3EQaw936yaFoFgAB
```

# Level 4 - 5

The password for the next level is stored in the only human-readable file in the inhere directory. Tip: if your terminal is messed up, try the “reset” command.

```
bandit4@bandit:~$ cat $(find ./inhere -exec file {} + | grep ASCII | cut -d ":" -f 1)
koReBOKuIDDepwhWk7jZC0RTdopnAYKh
bandit4@bandit:~$
```

# Level 5 - 6

The password for the next level is stored in a file somewhere under the inhere directory and has all of the following properties:

human-readable
1033 bytes in size
not executable

```

```