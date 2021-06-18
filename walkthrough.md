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
gzip -d data.gz
tar -xf data.tar
bzip2 -d data.bz
```

```
bandit12@bandit:~$ ls
data.txt
bandit12@bandit:~$ file data.txt
data.txt: ASCII text
bandit12@bandit:~$ head data.txt
00000000: 1f8b 0808 0650 b45e 0203 6461 7461 322e  .....P.^..data2.
00000010: 6269 6e00 013d 02c2 fd42 5a68 3931 4159  bin..=...BZh91AY
00000020: 2653 598e 4f1c c800 001e 7fff fbf9 7fda  &SY.O...........
00000030: 9e7f 4f76 9fcf fe7d 3fff f67d abde 5e9f  ..Ov...}?..}..^.
00000040: f3fe 9fbf f6f1 feee bfdf a3ff b001 3b1b  ..............;.
00000050: 5481 a1a0 1ea0 1a34 d0d0 001a 68d3 4683  T......4....h.F.
00000060: 4680 0680 0034 1918 4c4d 190c 4000 0001  F....4..LM..@...
00000070: a000 c87a 81a3 464d a8d3 43c5 1068 0346  ...z..FM..C..h.F
00000080: 8343 40d0 3400 0340 66a6 8068 0cd4 f500  .C@.4..@f..h....
00000090: 69ea 6800 0f50 68f2 4d00 680d 06ca 0190  i.h..Ph.M.h.....
bandit12@bandit:~$ mkdir /tmp/boop
bandit12@bandit:~$ cat data.txt | xxd -r > /tmp/boop/data
bandit12@bandit:~$ cd /tmp/boop
bandit12@bandit:/tmp/boop$ file data
data: gzip compressed data, was "data2.bin", last modified: Thu May  7 18:14:30 2020, max compression, from Unix
bandit12@bandit:/tmp/boop$ mv data data.bin
bandit12@bandit:/tmp/boop$ mv data.bin data.gz
bandit12@bandit:/tmp/boop$ gzip -d data.gz
bandit12@bandit:/tmp/boop$ ls
data
bandit12@bandit:/tmp/boop$ file data
data: bzip2 compressed data, block size = 900k
bandit12@bandit:/tmp/boop$ mv data data.bz && bzip2 -d data.bz
bandit12@bandit:/tmp/boop$ ls
data
bandit12@bandit:/tmp/boop$ file data
data: gzip compressed data, was "data4.bin", last modified: Thu May  7 18:14:30 2020, max compression, from Unix
bandit12@bandit:/tmp/boop$ mv data data.gz && gzip -d data.gz
bandit12@bandit:/tmp/boop$ ls
data
bandit12@bandit:/tmp/boop$ file data
data: POSIX tar archive (GNU)
bandit12@bandit:/tmp/boop$ mv data data.tar && tar -xf data.tar
bandit12@bandit:/tmp/boop$ ls
data5.bin  data.tar
bandit12@bandit:/tmp/boop$ file data5.bin
data5.bin: POSIX tar archive (GNU)
bandit12@bandit:/tmp/boop$ file data5.bin
data5.bin: POSIX tar archive (GNU)
bandit12@bandit:/tmp/boop$ mv data5.bin data.tar && tar -xf data.tar
bandit12@bandit:/tmp/boop$ ls
data6.bin  data.tar
bandit12@bandit:/tmp/boop$ file data6.bin
data6.bin: bzip2 compressed data, block size = 900k
bandit12@bandit:/tmp/boop$ mv data6.bin data.bz && bzip2 -d data.bz
bandit12@bandit:/tmp/boop$ ls
data  data.tar
bandit12@bandit:/tmp/boop$ file data
data: POSIX tar archive (GNU)
bandit12@bandit:/tmp/boop$ mv data data.tar && tar -xf data.tar && rm data.tar
bandit12@bandit:/tmp/boop$ ls
data8.bin
bandit12@bandit:/tmp/boop$ file data8.bin
data8.bin: gzip compressed data, was "data9.bin", last modified: Thu May  7 18:14:30 2020, max compression, from Unix
bandit12@bandit:/tmp/boop$ mv data8.bin data.gz && gzip -d data.gz
bandit12@bandit:/tmp/boop$ ls
data
bandit12@bandit:/tmp/boop$ file data
data: ASCII text
bandit12@bandit:/tmp/boop$ cat data
The password is 8ZjyCRiBWFYkneahHwxCv3wb2a1ORpYL
```

# Level 13 - 15

## Level 13 - 14

The password for the next level is stored in /etc/bandit_pass/bandit14 and can only be read by user bandit14. For this level, you don’t get the next password, but you get a private SSH key that can be used to log into the next level. Note: localhost is a hostname that refers to the machine you are working on.

```
andit13@bandit:~$ ls
sshkey.private
bandit13@bandit:~$ pwd
/home/bandit13
bandit13@bandit:~$ cat sshkey.private
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAxkkOE83W2cOT7IWhFc9aPaaQmQDdgzuXCv+ppZHa++buSkN+

...

/+aLoRQ0yBDRbdXMsZN/jvY44eM+xRLdRVyMmdPtP8belRi2E2aEzA==
-----END RSA PRIVATE KEY-----
bandit13@bandit:~$ logout
Connection to bandit.labs.overthewire.org closed.
> ssh -i ./temp/bandit14Key bandit14@bandit.labs.overthewire.org -p 2220
This is a OverTheWire game server. More information on http://www.overthewire.org/wargames

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@         WARNING: UNPROTECTED PRIVATE KEY FILE!          @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
Permissions 0644 for './temp/bandit14Key' are too open.
It is required that your private key files are NOT accessible by others.
This private key will be ignored.
Load key "./temp/bandit14Key": bad permissions
bandit14@bandit.labs.overthewire.org's password:

> chmod 600 ./temp/bandit14Key
> ssh -i ./temp/bandit14Key bandit14@bandit.labs.overthewire.org -p 2220
This is a OverTheWire game server. More information on http://www.overthewire.org/wargames

Linux bandit.otw.local 5.4.8 x86_64 GNU/Linux

...

--[ More information ]--

  For more information regarding individual wargames, visit
  http://www.overthewire.org/wargames/

  For support, questions or comments, contact us through IRC on
  irc.overthewire.org #wargames.

  Enjoy your stay!

bandit14@bandit:~$ cat /etc/bandit_pass/bandit14
4wcYUJFw0k0XLShlDzztnTBHiqxU3b3e
```

## Level 14 - 15

The password for the next level can be retrieved by submitting the password of the current level to port 30000 on localhost.

```
bandit14@bandit:~$ echo 4wcYUJFw0k0XLShlDzztnTBHiqxU3b3e | nc localhost 30000
Correct!
BfMYroe26WYalil77FoDi9qh59eK5xNr
```

# Level 15 - 16

The password for the next level can be retrieved by submitting the password of the current level to port 30001 on localhost using SSL encryption.

```
bandit15@bandit:~$ echo "BfMYroe26WYalil77FoDi9qh59eK5xNr" | openssl s_client -connect localhost:30001 -ign_eof | tail -n 3 | head -n 1
depth=0 CN = localhost
verify error:num=18:self signed certificate
verify return:1
depth=0 CN = localhost
verify return:1
cluFn7wTiGryunymYOu4RcffSxQluehd
```

# level 16 - 17

The credentials for the next level can be retrieved by submitting the password of the current level to a port on localhost in the range 31000 to 32000. First find out which of these ports have a server listening on them. Then find out which of those speak SSL and which don’t. There is only 1 server that will give the next credentials, the others will simply send back to you whatever you send to it.

```
bandit16@bandit:~$ nmap -sV -p 31000-32000 localhost | grep "ssl/unknown" | cut -d " " -f
131790/tcp
bandit16@bandit:~$ PORT=$(echo "31790/tcp" | cut -d "/" -f 1); echo "cluFn7wTiGryunymYOu4RcffSxQluehd" | openssl s_client -connect localhost:$PORT -ign_eof;
CONNECTED(00000003)
depth=0 CN = localhost
verify error:num=18:self signed certificate
verify return:1
depth=0 CN = localhost
verify return:1
---
Certificate chain
 0 s:/CN=localhost
   i:/CN=localhost
---
Server certificate
-----BEGIN CERTIFICATE-----
MIICBjCCAW+gAwIBAgIESK0prjANBgkqhkiG9w0BAQUFADAUMRIwEAYDVQQDDAls
b2NhbGhvc3QwHhcNMjEwNjE0MTkzOTAyWhcNMjIwNjE0MTkzOTAyWjAUMRIwEAYD
VQQDDAlsb2NhbGhvc3QwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAL3AJi7+
mhQwXXHZweajk45kDauQ8gItcbmfbmCE8dvjBuzjFho+nN9OZ/5xPHjNy+15d+Kr
iv+p1DPsjtPdDP5LNhShGBJIdj+h1DanaQbZnILW64fmbZPQzsvf1U0q3KUX/Hr5
OlZNV5eryXtPGELBddTVB4QyRo7qEdCIjf83AgMBAAGjZTBjMBQGA1UdEQQNMAuC
CWxvY2FsaG9zdDBLBglghkgBhvhCAQ0EPhY8QXV0b21hdGljYWxseSBnZW5lcmF0
ZWQgYnkgTmNhdC4gU2VlIGh0dHBzOi8vbm1hcC5vcmcvbmNhdC8uMA0GCSqGSIb3
DQEBBQUAA4GBACDBqqnOEy6516ocDng2iqNRS+mLAiaVKONccL+847NK54W4g4Wo
0PdPF4dVhkNiLGJDcrx3aY4A+u+aFAcZmDYJOFsGJMCBOdle8v9PvQ6V/y8x4TkR
JUvpO+seiTk7lj/4byRQXlHcYxMdAflrDl+m9tKeDJlYaAPO5d9P28Iv
-----END CERTIFICATE-----
subject=/CN=localhost
issuer=/CN=localhost
---
No client certificate CA names sent
Peer signing digest: SHA512
Server Temp Key: X25519, 253 bits
---
SSL handshake has read 1019 bytes and written 269 bytes
Verification error: self signed certificate
---
New, TLSv1.2, Cipher is ECDHE-RSA-AES256-GCM-SHA384
Server public key is 1024 bit
Secure Renegotiation IS supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
SSL-Session:
    Protocol  : TLSv1.2
    Cipher    : ECDHE-RSA-AES256-GCM-SHA384
    Session-ID: 40DABFD97EA6D4C4A0A025C02E118AF1691E767A2F45750D6687B663167B082C
    Session-ID-ctx:
    Master-Key: 9CA370153B1A23EEB981C55852BD72573E3092355F4EF2783BA1EF6CED80F3264F33D4D2E3C2EE8F340C0D70E3D69C3D
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    TLS session ticket lifetime hint: 7200 (seconds)
    TLS session ticket:
    0000 - 4d 56 29 e9 f1 5c 3e 86-5d 40 4d 5e 38 22 f0 d1   MV)..\>.]@M^8"..
    0010 - ab d2 fb 4c 47 e6 87 c7-14 26 f6 53 f7 cb 8c 5c   ...LG....&.S...\
    0020 - 2f 52 3c 55 7b 63 95 e2-ff 98 55 0f 11 34 3c bd   /R<U{c....U..4<.
    0030 - 14 35 14 c9 69 db f4 e1-22 5d 03 1b 72 95 28 b3   .5..i..."]..r.(.
    0040 - 92 f9 64 5f 6e ef 52 c0-05 a8 fd 23 1c 75 c1 f7   ..d_n.R....#.u..
    0050 - eb f9 52 e9 db 9e 96 47-e9 1d 39 b8 fd 0b ac d4   ..R....G..9.....
    0060 - 49 3a 27 d1 f3 86 59 80-22 3c 73 dd 7d 69 63 29   I:'...Y."<s.}ic)
    0070 - b4 4f 4f ff fc 7d a3 5b-29 9d d3 d5 ad 62 2b 85   .OO..}.[)....b+.
    0080 - 89 7f cf c6 8b 47 e9 e0-6e c0 7b 05 81 62 63 99   .....G..n.{..bc.
    0090 - de 8b 7c c3 1f 8d 9c 1f-29 01 93 d2 6b a8 0e 32   ..|.....)...k..2

    Start Time: 1623988051
    Timeout   : 7200 (sec)
    Verify return code: 18 (self signed certificate)
    Extended master secret: yes
---
Correct!
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAvmOkuifmMg6HL2YPIOjon6iWfbp7c3jx34YkYWqUH57SUdyJ
imZzeyGC0gtZPGujUSxiJSWI/oTqexh+cAMTSMlOJf7+BrJObArnxd9Y7YT2bRPQ
Ja6Lzb558YW3FZl87ORiO+rW4LCDCNd2lUvLE/GL2GWyuKN0K5iCd5TbtJzEkQTu
DSt2mcNn4rhAL+JFr56o4T6z8WWAW18BR6yGrMq7Q/kALHYW3OekePQAzL0VUYbW
JGTi65CxbCnzc/w4+mqQyvmzpWtMAzJTzAzQxNbkR2MBGySxDLrjg0LWN6sK7wNX
x0YVztz/zbIkPjfkU1jHS+9EbVNj+D1XFOJuaQIDAQABAoIBABagpxpM1aoLWfvD
KHcj10nqcoBc4oE11aFYQwik7xfW+24pRNuDE6SFthOar69jp5RlLwD1NhPx3iBl
J9nOM8OJ0VToum43UOS8YxF8WwhXriYGnc1sskbwpXOUDc9uX4+UESzH22P29ovd
d8WErY0gPxun8pbJLmxkAtWNhpMvfe0050vk9TL5wqbu9AlbssgTcCXkMQnPw9nC
YNN6DDP2lbcBrvgT9YCNL6C+ZKufD52yOQ9qOkwFTEQpjtF4uNtJom+asvlpmS8A
vLY9r60wYSvmZhNqBUrj7lyCtXMIu1kkd4w7F77k+DjHoAXyxcUp1DGL51sOmama
+TOWWgECgYEA8JtPxP0GRJ+IQkX262jM3dEIkza8ky5moIwUqYdsx0NxHgRRhORT
8c8hAuRBb2G82so8vUHk/fur85OEfc9TncnCY2crpoqsghifKLxrLgtT+qDpfZnx
SatLdt8GfQ85yA7hnWWJ2MxF3NaeSDm75Lsm+tBbAiyc9P2jGRNtMSkCgYEAypHd
HCctNi/FwjulhttFx/rHYKhLidZDFYeiE/v45bN4yFm8x7R/b0iE7KaszX+Exdvt
SghaTdcG0Knyw1bpJVyusavPzpaJMjdJ6tcFhVAbAjm7enCIvGCSx+X3l5SiWg0A
R57hJglezIiVjv3aGwHwvlZvtszK6zV6oXFAu0ECgYAbjo46T4hyP5tJi93V5HDi
Ttiek7xRVxUl+iU7rWkGAXFpMLFteQEsRr7PJ/lemmEY5eTDAFMLy9FL2m9oQWCg
R8VdwSk8r9FGLS+9aKcV5PI/WEKlwgXinB3OhYimtiG2Cg5JCqIZFHxD6MjEGOiu
L8ktHMPvodBwNsSBULpG0QKBgBAplTfC1HOnWiMGOU3KPwYWt0O6CdTkmJOmL8Ni
blh9elyZ9FsGxsgtRBXRsqXuz7wtsQAgLHxbdLq/ZJQ7YfzOKU4ZxEnabvXnvWkU
YOdjHdSOoKvDQNWu6ucyLRAWFuISeXw9a/9p7ftpxm0TSgyvmfLF2MIAEwyzRqaM
77pBAoGAMmjmIJdjp+Ez8duyn3ieo36yrttF5NSsJLAbxFpdlc1gvtGCWW+9Cq0b
dxviW8+TFVEBl1O4f7HVm6EpTscdDxU+bCXWkfjuRb7Dy9GOtt9JPsX8MBTakzh3
vBgsyi/sN3RqRBcGU40fOoZyfAMT8s1m/uYv52O6IgeuZ/ujbjY=
-----END RSA PRIVATE KEY-----

closed
```

```
bandit16@bandit:~$ PORT=$(nmap -sV -p 31000-32000 localhost | grep 'ssl/unknown' | cut -d ' ' -f 1 | cut -d '/' -f 1); echo "cluFn7wTiGryunymYOu4RcffSxQluehd" | openssl s_client -connect localhost:$PORT -ign_eof | sed -n '/Correct!/,$p' | sed -n '1!p' | head -n -2 > /tmp/myotherboop/nextKey.pem
depth=0 CN = localhost
verify error:num=18:self signed certificate
verify return:1
depth=0 CN = localhost
verify return:1
bandit16@bandit:~$ cat /tmp/myotherboop/nextKey.pem
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAvmOkuifmMg6HL2YPIOjon6iWfbp7c3jx34YkYWqUH57SUdyJ
imZzeyGC0gtZPGujUSxiJSWI/oTqexh+cAMTSMlOJf7+BrJObArnxd9Y7YT2bRPQ
Ja6Lzb558YW3FZl87ORiO+rW4LCDCNd2lUvLE/GL2GWyuKN0K5iCd5TbtJzEkQTu
DSt2mcNn4rhAL+JFr56o4T6z8WWAW18BR6yGrMq7Q/kALHYW3OekePQAzL0VUYbW
JGTi65CxbCnzc/w4+mqQyvmzpWtMAzJTzAzQxNbkR2MBGySxDLrjg0LWN6sK7wNX
x0YVztz/zbIkPjfkU1jHS+9EbVNj+D1XFOJuaQIDAQABAoIBABagpxpM1aoLWfvD
KHcj10nqcoBc4oE11aFYQwik7xfW+24pRNuDE6SFthOar69jp5RlLwD1NhPx3iBl
J9nOM8OJ0VToum43UOS8YxF8WwhXriYGnc1sskbwpXOUDc9uX4+UESzH22P29ovd
d8WErY0gPxun8pbJLmxkAtWNhpMvfe0050vk9TL5wqbu9AlbssgTcCXkMQnPw9nC
YNN6DDP2lbcBrvgT9YCNL6C+ZKufD52yOQ9qOkwFTEQpjtF4uNtJom+asvlpmS8A
vLY9r60wYSvmZhNqBUrj7lyCtXMIu1kkd4w7F77k+DjHoAXyxcUp1DGL51sOmama
+TOWWgECgYEA8JtPxP0GRJ+IQkX262jM3dEIkza8ky5moIwUqYdsx0NxHgRRhORT
8c8hAuRBb2G82so8vUHk/fur85OEfc9TncnCY2crpoqsghifKLxrLgtT+qDpfZnx
SatLdt8GfQ85yA7hnWWJ2MxF3NaeSDm75Lsm+tBbAiyc9P2jGRNtMSkCgYEAypHd
HCctNi/FwjulhttFx/rHYKhLidZDFYeiE/v45bN4yFm8x7R/b0iE7KaszX+Exdvt
SghaTdcG0Knyw1bpJVyusavPzpaJMjdJ6tcFhVAbAjm7enCIvGCSx+X3l5SiWg0A
R57hJglezIiVjv3aGwHwvlZvtszK6zV6oXFAu0ECgYAbjo46T4hyP5tJi93V5HDi
Ttiek7xRVxUl+iU7rWkGAXFpMLFteQEsRr7PJ/lemmEY5eTDAFMLy9FL2m9oQWCg
R8VdwSk8r9FGLS+9aKcV5PI/WEKlwgXinB3OhYimtiG2Cg5JCqIZFHxD6MjEGOiu
L8ktHMPvodBwNsSBULpG0QKBgBAplTfC1HOnWiMGOU3KPwYWt0O6CdTkmJOmL8Ni
blh9elyZ9FsGxsgtRBXRsqXuz7wtsQAgLHxbdLq/ZJQ7YfzOKU4ZxEnabvXnvWkU
YOdjHdSOoKvDQNWu6ucyLRAWFuISeXw9a/9p7ftpxm0TSgyvmfLF2MIAEwyzRqaM
77pBAoGAMmjmIJdjp+Ez8duyn3ieo36yrttF5NSsJLAbxFpdlc1gvtGCWW+9Cq0b
dxviW8+TFVEBl1O4f7HVm6EpTscdDxU+bCXWkfjuRb7Dy9GOtt9JPsX8MBTakzh3
vBgsyi/sN3RqRBcGU40fOoZyfAMT8s1m/uYv52O6IgeuZ/ujbjY=
-----END RSA PRIVATE KEY-----
```

# Level 17 - 18

There are 2 files in the homedirectory: passwords.old and passwords.new. The password for the next level is in passwords.new and is the only line that has been changed between passwords.old and passwords.new

```
bandit17@bandit:~$ ls
passwords.new  passwords.old
bandit17@bandit:~$ diff passwords.{old,new}
42c42
< w0Yfolrc5bwjS4qw5mq1nnQi6mF03bii
---
> kfBf3eYk5BPBRzwjqutbbfE887SVc5Yd
bandit17@bandit:~$
```

# Level 18 - 19

The password for the next level is stored in a file readme in the homedirectory. Unfortunately, someone has modified .bashrc to log you out when you log in with SSH.

```
> ssh bandit18@bandit.labs.overthewire.org -p 2220 cat readme
This is a OverTheWire game server. More information on http://www.overthewire.org/wargames

bandit18@bandit.labs.overthewire.org's password:
IueksS7Ubh8G3DCwVzrTd8rAVOwq3M5x
```

# Level 19 - 20

To gain access to the next level, you should use the setuid binary in the homedirectory. Execute it without arguments to find out how to use it. The password for this level can be found in the usual place (/etc/bandit_pass), after you have used the setuid binary.

```
bandit19@bandit:~$ ls -lah
total 28K
drwxr-xr-x  2 root     root     4.0K May  7  2020 .
drwxr-xr-x 41 root     root     4.0K May  7  2020 ..
-rwsr-x---  1 bandit20 bandit19 7.2K May  7  2020 bandit20-do
-rw-r--r--  1 root     root      220 May 15  2017 .bash_logout
-rw-r--r--  1 root     root     3.5K May 15  2017 .bashrc
-rw-r--r--  1 root     root      675 May 15  2017 .profile
bandit20-do
bandit19@bandit:~$ ./bandit20-do cat /etc/bandit_pass/bandit20
GbKksEFF4yrVs6il55v6gwY5aVje5f0j
```

# Level 20 - 21

There is a setuid binary in the homedirectory that does the following: it makes a connection to localhost on the port you specify as a commandline argument. It then reads a line of text from the connection and compares it to the password in the previous level (bandit20). If the password is correct, it will transmit the password for the next level (bandit21).

```

```