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
bandit5@bandit:~$ cat $(find ./inhere/ -size 1033c ! -executable) | cut -d " " -f 1 | head -n 1
DXjZPULLxYr17uwoI01bNLQbtFemEgo7
bandit5@bandit:~$
```

# Level 6 - 7

The password for the next level is stored somewhere on the server and has all of the following properties:

owned by user bandit7
owned by group bandit6
33 bytes in size

```
bandit6@bandit:~$ find / -size 33c -user bandit7 -group bandit6 2>/dev/null
/var/lib/dpkg/info/bandit7.password
bandit6@bandit:~$ cat /var/lib/dpkg/info/bandit7.password
HKBPTKQnIay4Fw76bEy8PVxKEDQRKTzs
```

# Level 7 - 8

The password for the next level is stored in the file data.txt next to the word millionth

```
bandit7@bandit:~$ ls
data.txt
bandit7@bandit:~$ cat data.txt | grep millionth
millionth	cvX2JJa4CFALtqS87jk27qwqGhBM9plV
bandit7@bandit:~$
```

# Level 8 - 9

The password for the next level is stored in the file data.txt and is the only line of text that occurs only once

```
bandit8@bandit:~$ sort data.txt | uniq -u
UsvVyFSfZZWbi6wgC7dAFyFuR6jQQUhR
```

```
bandit8@bandit:~$ awk '{!seen[$0]++};END{for(i in seen) if(seen[i]==1)print i}' data.txt
UsvVyFSfZZWbi6wgC7dAFyFuR6jQQUhR
```

# Level 9 - 10

The password for the next level is stored in the file data.txt in one of the few human-readable strings, preceded by several ‘=’ characters.

```
bandit9@bandit:~$ ls
data.txt
bandit9@bandit:~$ strings data.txt | grep '='
========== the*2i"4
=:G e
========== password
<I=zsGi
Z)========== is
A=|t&E
Zdb=
c^ LAh=3G
*SF=s
&========== truKLdjsbJ5g7yyJ2X2R0o3a5HQJFuLk
S=A.H&^
bandit9@bandit:~$ strings data.txt | grep '==='
========== the*2i"4
========== password
Z)========== is
&========== truKLdjsbJ5g7yyJ2X2R0o3a5HQJFuLk
bandit9@bandit:~$ strings data.txt | grep '===' | tail -1
&========== truKLdjsbJ5g7yyJ2X2R0o3a5HQJFuLk
bandit9@bandit:~$ strings data.txt | grep '===' | tail -1 | cut -d ' ' -f 2
truKLdjsbJ5g7yyJ2X2R0o3a5HQJFuLk
```

# Level 10 - 11

The password for the next level is stored in the file data.txt, which contains base64 encoded data

```
bandit10@bandit:~$ ls
data.txt
bandit10@bandit:~$ cat data.txt | base64 -d
The password is IFukwKGsFW8MOq3IRFqrxE1hxTNEbUPR
bandit10@bandit:~$ cat data.txt | base64 -d | awk '{print $(NF)}'
IFukwKGsFW8MOq3IRFqrxE1hxTNEbUPR
```

# Level 11 - 12

The password for the next level is stored in the file data.txt, where all lowercase (a-z) and uppercase (A-Z) letters have been rotated by 13 positions

```
bandit11@bandit:~$ ls
data.txt
bandit11@bandit:~$ cat data.txt
Gur cnffjbeq vf 5Gr8L4qetPEsPk8htqjhRK8XSP6x2RHh
bandit11@bandit:~$ cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
The password is 5Te8Y4drgCRfCx8ugdwuEX8KFC6k2EUu
```

# Level 12 - 13

The password for the next level is stored in the file data.txt, which is a hexdump of a file that has been repeatedly compressed. For this level it may be useful to create a directory under /tmp in which you can work using mkdir. For example: mkdir /tmp/myname123. Then copy the datafile using cp, and rename it using mv (read the manpages!)

Useful commands
```

```

```

```