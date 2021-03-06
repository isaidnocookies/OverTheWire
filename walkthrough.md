# Level 0 - 1

The goal of this level is for you to log into the game using SSH. The host to which you need to connect is bandit.labs.overthewire.org, on port 2220. The username is bandit0 and the password is bandit0. Once logged in, go to the Level 1 page to find out how to beat Level 1.

### Summary

Level0 is simple: read the text file. Cat is used to print the contents of the 'readme' file to standard out. 'Cat' is short for 'concatenate' and is meant to concatenate or add files together and then print to standard output.

Additionally, ssh can be used to run commands remotely without using a remote shell by putting commands at the end of the ssh command. To make the process easier, 'sshpass' can be used to input the password without needing to manually do it via the password prompt. This is seen in the second solution by passing the password in after the '-p' option.

### Solution(s)

```
bandit0@bandit:~$ cat readme
boJ9jbbUNNfktd78OOpsqOltutMc3MY1
```

```
> sshpass -p "bandit0" ssh bandit0@bandit.labs.overthewire.org -p 2220 cat readme
This is a OverTheWire game server. More information on http://www.overthewire.org/wargames

boJ9jbbUNNfktd78OOpsqOltutMc3MY1
```

# Level 1 - 2

The password for the next level is stored in a file called - located in the home directory

### Summary

Level 1 is similar to Level 0 but instead of reading from a file named 'readme' the file is named '-'. This complicates the process because if a '-' character follows most commands, the command will attempt to parse it as an option (e.g., 'ls -lah'). To explicitly read the file and interpret the filename as a filename, we can reference the file while using pathing to explicitly point to it as a file.

Within the linux filesystem, the current directory is referenced with a single dot (i.e., './') and the previous directory is referenced with two dots (i.e., '../'). These can be seen at the top of the file listing when using 'ls -lah'.

### Solution(s)

```
bandit1@bandit:~$ cat ./-
```

```
sshpass -p "boJ9jbbUNNfktd78OOpsqOltutMc3MY1" ssh bandit1@bandit.labs.overthewire.org -p 2220 cat ./-
```

# Level 2 - 3

The password for the next level is stored in a file called spaces in this filename located in the home directory

### Summary

Spaces can cause problems when used in file or directory names. To reference a filename with spaces, the spaces can be 'escaped'. This means that the spaces will be read as characters within the string rather than a separator within the command. To speed up the process, you can tab complete the filename by starting to type 'spaces' and then pressing tab to autocomplete.

### Solution(s)

```
bandit2@bandit:~$ cat spaces\ in\ this\ filename
UmHadQclWmgdLOKQ3YNgjWxGoRMb5luK
```

# Level 3 - 4

The password for the next level is stored in a hidden file in the inhere directory

### Summary

Hidden files aren't normally shown when listing the contents of the directory but can be viewed with the '-a' option when using the 'ls' command. Once you find the hidden file (any files starting with a period are considered hidden), it can be read as we have in previous levels with the 'cat' command.

### Solution(s)

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

The password for the next level is stored in the only human-readable file in the inhere directory. Tip: if your terminal is messed up, try the ???reset??? command.

### Summary

Level 4 introduces the challenge of finding a file that meets certain specification. To quickly find the relevant file, we can  use the 'find' command within the './.inhere' directory. Find allows us to execute a command on each file found by the 'find' command so we run the 'file' command on each file within the directory listed in the command (i.e., './inhere). Since the 'file' command will return a short overview of the file type of each file, we can 'grep' for the word 'ASCII' in the output. Once we have that output, we can cut out the password using the cut command.

Cut is used to clean up the output and strip out the unnecessary information. This makes it easier to pipe this into other commands or save for future use. The 'cut' command used below specifies the delimiter ('-d') as the character ':' and then specifies we only want the first field ('-f 1'). Cut starts it's indexing at 1 so this will be the first field returned by cut once the string is seperated by our specified delimiter.

### Solution(s)

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

### Summary

Level 5 is very similar to level 4 but with additional requirements. This can be seen by using the '-size' option and specifying '1033c'. In linux, and computer programming in general, characters or the 'char' variable type is 1 byte or 8 bits. So, in the find command, we specify that we want to look for files that are 1033 bytes long by specifying with the 'c' character. Next, we want to exclude executable files. This is done by adding the 'not' indicator (i.e., '!') followed by the '-executable' option. Without the exclamation point, it would only look for executable files that are 1033 bytes in size.

For this level, the find command was encapsulated in the '$()' characters to tell bash to evaluate this first and then use the output of those commands in its place. This allows us to return the filename, and then immediately 'cat' it. Next, we clean up the output by taking the first field and then only returning the first line in the output (designated by 'head -n 1').

The 'head' command can be very useful when looking at large files. This command defaults to printing the first 10 lines of the file to standard output but we can specify that we only want one line ('-n 1') instead.

### Solution(s)

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

### Summary

Building on level 5, we can add additional specifiers to only return files that are 33 bytes long that are also owned by the user 'bandit7' and the group 'bandit6'. To remove all warnings and errors, we can redirect the standard error output (output to the file descriptor 2) to '/dev/null'. '/dev/null' is a 'file' on linux systems that takes input and immediately throws it away. This is similar to throwing data into a black hole. 

### Solution(s)

```
bandit6@bandit:~$ find / -size 33c -user bandit7 -group bandit6 2>/dev/null
/var/lib/dpkg/info/bandit7.password
bandit6@bandit:~$ cat /var/lib/dpkg/info/bandit7.password
HKBPTKQnIay4Fw76bEy8PVxKEDQRKTzs
```

# Level 7 - 8

The password for the next level is stored in the file data.txt next to the word millionth

### Summary

We can again use grep to search for the world 'millionth' in the 'data.txt' file.

### Solution(s)

```
bandit7@bandit:~$ ls
data.txt
bandit7@bandit:~$ cat data.txt | grep millionth
millionth	cvX2JJa4CFALtqS87jk27qwqGhBM9plV
bandit7@bandit:~$
```

# Level 8 - 9

The password for the next level is stored in the file data.txt and is the only line of text that occurs only once

### Summary

Since we know that the password only occurs once, we can sort the data to place all duplicate lines  next to each other. Once the file is sorted, we can pull out the unique lines within the file by piping it into the 'uniq' command.

Another more efficient way of solving this problem is by using 'awk'. Awk is an incredibly powerful language that is designed for text processing and data extraction. In the second solution we use awk to count each occurrence and only print the lines that occurred once. In fact, awk is a Turing complete language and is capable of much more than parsing simple text files.

### Solution(s)

```
bandit8@bandit:~$ sort data.txt | uniq -u
UsvVyFSfZZWbi6wgC7dAFyFuR6jQQUhR
```

```
bandit8@bandit:~$ awk '{!seen[$0]++};END{for(i in seen) if(seen[i]==1)print i}' data.txt
UsvVyFSfZZWbi6wgC7dAFyFuR6jQQUhR
```

# Level 9 - 10

The password for the next level is stored in the file data.txt in one of the few human-readable strings, preceded by several ???=??? characters.

### Summary

Level 9 specifies that our password is on a human-readable line followed by '=' characters. To pull out all the human-readable strings, we can use the 'strings' command. This command is commonly used in reverse engineering to find strings within a binary. Once we have all the readable strings, we can grep for the '==' characters and find the password.

In the later commands within the solution, we iterate on our solution to remove more of the unnecessary data. One of the commands we use is the 'tail' command to print the last line of the output. This is the opposite of the 'head' command.

### Solution(s)

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

### Summary

Base64 encoding takes characters or binary data and converts them into a radix-64 representation. More simply put, it converts the data to something that is guaranteed to be printable. Base64 uses the characters '0-9', 'A-Z', 'a-z', +, '/' and '=' for padding.

To convert to and from base64 via the command line, we can use the 'base64' command. The 'base64' command along with the decode option (i.e., '-d') will take the output from 'data.txt' and decode it.

Finally, we can use awk to pull out the last column of data using the built in '$(NF)' variable.

### Solution(s)

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

### Summary

Rot13 is a simple cipher that shifts the position of each character 13 positions. We can use the translate command (i.e., 'tr') to translate 'A-Z' to 'N-Z' and 'A-M' along with the lowercase equivalent. This translates the text from the normal next to the corresponding character 13 characters away.

Another easy way is to google 'Rot13 decoder' and pasting the data into an online tool. Some common tools for decoding ciphers is rumkin.com and gchq.github.io/CyberChef.

### Solution(s)

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

### Summary

Binary files can be converted to a hex format commonly seen by decompilers and disassemblers. To reverse this conversion, we can use the 'xxd' command with the reverse option (i.e., '-r'). Once 'xxd' has converted the file back to a binary file, we can output that to a file we have write permissions on (done with the '>' character following the 'xxd' command).

Once we have the file in a format we can work with, we need to figure out what type of file it is. By running the 'file' command, we can get an idea of what the filetype is. Once we know, we can rename it to have the proper extension and use the correct tool to decompress it. This is done repeatedly until we are left with a human-readable ASCII file.

### Useful commands

```
gzip -d data.gz
tar -xf data.tar
bzip2 -d data.bz
```

### Solution(s)

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

The password for the next level is stored in /etc/bandit_pass/bandit14 and can only be read by user bandit14. For this level, you don???t get the next password, but you get a private SSH key that can be used to log into the next level. Note: localhost is a hostname that refers to the machine you are working on.

### Summary

Up until now, we have been SSHing into the machines using passwords. Now we have a private key to use instead of the passwords. Once we get the private key in the bandit13 home directory, we can save that file and connect to bandit14 user with the key. This is done with the '-i' option within SSH. The '-i' option stands for 'identity' and allows us to use asymmetric encryption instead of simple passwords.

You'll also note that we get a permissions error when trying to use the file. This is a safety mechanism built into the SSH tool that prevents you from using SSH keys that are too available to other users on the system. We can change the mode or permissions of the key with the 'chmod' command. We use the mode '600' to specify that only our user can read and write the file and no other user can read, write, or execute the private key.

### Solution(s)

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

### Summary

Netcat can be used to interact with different services and open ports and is one of the most useful tools in cybersecurity and hacking. For this level, we echo, or print back to stdout, the password for the current level and pipe it to a netcat ('nc') session. We connect to port 30000 on the local machine or 'localhost' by making the connection with 'nc localhost 30000'.

### Solution(s)

```
bandit14@bandit:~$ echo 4wcYUJFw0k0XLShlDzztnTBHiqxU3b3e | nc localhost 30000
Correct!
BfMYroe26WYalil77FoDi9qh59eK5xNr
```

# Level 15 - 16

The password for the next level can be retrieved by submitting the password of the current level to port 30001 on localhost using SSL encryption.

### Summary

Netcat opens up a connection without any encryption or secure mechanisms. To use a service that forces encryption or use of TLS/SSL certifications, we can use the openssl command. Openssl is a valuable tool that allows us to create and manage certifications, and interact with TLS/SSL applications.

### Solution(s)

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

The credentials for the next level can be retrieved by submitting the password of the current level to a port on localhost in the range 31000 to 32000. First find out which of these ports have a server listening on them. Then find out which of those speak SSL and which don???t. There is only 1 server that will give the next credentials, the others will simply send back to you whatever you send to it.

### Summary

This level is a combination of a couple of the previous levels with a twist--we don't know which port to connect to. Using Nmap (network mapper), we can scan the given port range and search for the port listening with an attached ssl service. The '-sV' option used with Nmap attempts to scan and return the associated services for each port--referenced as service discovery.

In order to create a single command to complete the level, the PORT variable is set, and then used in the next connect command. This sets it for the duration of the session and allows us to use it without manually typing the port each time.

### Solution(s)

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

### Summary

Diffing is the act of taking multiple files and determining the differences between them. This is a valuable tool used to determine what kind of changes happen between files or different versions of a file. We also use brace expansion to cut down on typing. This takes 'passwords.' and appends 'old' and 'new' to form two strings. This allows us to avoid typing the prefix of the filename each time.

### Solution(s)

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

### Summary

This challenege was quite easy if the read commands are passed in via the ssh command rather than manually when the shell is opened. Since we can tack on commands to the end of the ssh command, they are executed without worrying about whatever was modified in the '.bashrc' file.

### Solution(s)

```
> ssh bandit18@bandit.labs.overthewire.org -p 2220 cat readme
This is a OverTheWire game server. More information on http://www.overthewire.org/wargames

bandit18@bandit.labs.overthewire.org's password:
IueksS7Ubh8G3DCwVzrTd8rAVOwq3M5x
```

# Level 19 - 20

To gain access to the next level, you should use the setuid binary in the homedirectory. Execute it without arguments to find out how to use it. The password for this level can be found in the usual place (/etc/bandit_pass), after you have used the setuid binary.

### Summary

Setuid binaries set the user ID on execution meaning the user will execute the file with the permissions of the user who owns the file. Since 'bandit20-do' is owned by bandit20, we can run the binary and pass in commands to be run as if bandit20 was running it. This allows us to read the bandit20 password as if we are bandit20.

This permission is shown in the list command with the 's' after the '-rw' permission.

### Solution(s)

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

### Summary

To start, we need to create a netcat listener that returns the contents of the password file each time a user connects to the service. This means that anyone who connects to the listener on port 4444 will recieve the contents of the 'bandit20' password file. To run this command in the background while we execute the 'suconnect' file, we can add the '&' character to the end of the command. This immediately backgrounds the command and allows us to continue using the terminal without creating a new session in another window. Once we execute the 'suconnect' binary, it reads the contents of the password file from the netcat listener and returns the next password.

While the netcat listener is running, you can see the current jobs by using the 'jobs' command. If you forget to run the command with the '&' character, you can also press ctrl-z to background the current process. Once backgrounded, it will be paused so we can either continue the process in the foreground with the 'fg' command or in the background with the 'bg' command.

### Solution(s)

```
bandit20@bandit:~$ ls
suconnect
bandit20@bandit:~$ nc -nvlp 4444 < /etc/bandit_pass/bandit20 &
[1] 16006
bandit20@bandit:~$ listening on [any] 4444 ...

bandit20@bandit:~$ ./suconnect 4444
connect to [127.0.0.1] from (UNKNOWN) [127.0.0.1] 44364
Read: GbKksEFF4yrVs6il55v6gwY5aVje5f0j
Password matches, sending next password
gE269g2h3mw3pwgrj0Ha9Uoqen1c9DGr
[1]+  Done                    nc -nvlp 4444 < /etc/bandit_pass/bandit20
bandit20@bandit:~$
```

# Level 21 - 22

A program is running automatically at regular intervals from cron, the time-based job scheduler. Look in /etc/cron.d/ for the configuration and see what command is being executed.

### Summary

Cronjobs allows you to schedule scripts or processes to run on a specified interval. To see the cronjobs, you can either use the 'crontab -l' command if you have the necessary privileges or read the cronjob files in the '/etc/cron.d' directory. Once we see what's running, we can see what script is being used and cat the contents of the script.

Within the script, we see that the cronjob is cating the contents of the next password file to a specific temp folder. We can read that folder as it sets the permissions to be readable by everyone--with the chmod 644 command--within the cronjob script.

### Solution(s)

```
bandit21@bandit:~$ cd /etc/cron.d
bandit21@bandit:/etc/cron.d$ ls
cronjob_bandit15_root  cronjob_bandit22  cronjob_bandit24
cronjob_bandit17_root  cronjob_bandit23  cronjob_bandit25_root
bandit21@bandit:/etc/cron.d$ cat cronjob_bandit22
@reboot bandit22 /usr/bin/cronjob_bandit22.sh &> /dev/null
* * * * * bandit22 /usr/bin/cronjob_bandit22.sh &> /dev/null
bandit21@bandit:/etc/cron.d$ cat /usr/bin/cronjob_bandit22.sh
#!/bin/bash
chmod 644 /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv
cat /etc/bandit_pass/bandit22 > /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv
bandit21@bandit:/etc/cron.d$ cat /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv
Yk7owGAcWjwMVRwrTesJEwB7WVOiILLI
bandit21@bandit:/etc/cron.d$
```

# Level 22 - 23

A program is running automatically at regular intervals from cron, the time-based job scheduler. Look in /etc/cron.d/ for the configuration and see what command is being executed.

### Summary

Following the same process as level 21, we look at what is being run by the cronjob scheduler. We see that there is a script that is creating an MD5 hash of the 'I am user $myname' string and taking the first field. We can recreate this string and cat that specific file in the '/tmp' directory. We again use the '$()' mechanism to take the output of the md5 hash generation and inject it into our cat command.

### Solution(s)

```
bandit22@bandit:~$ cd /etc/cron.d
bandit22@bandit:/etc/cron.d$ ls
cronjob_bandit15_root  cronjob_bandit22  cronjob_bandit24
cronjob_bandit17_root  cronjob_bandit23  cronjob_bandit25_root
bandit22@bandit:/etc/cron.d$ cat cronjob_bandit23
@reboot bandit23 /usr/bin/cronjob_bandit23.sh  &> /dev/null
* * * * * bandit23 /usr/bin/cronjob_bandit23.sh  &> /dev/null
bandit22@bandit:/etc/cron.d$ cat /usr/bin/cronjob_bandit23.sh
#!/bin/bash

myname=$(whoami)
mytarget=$(echo I am user $myname | md5sum | cut -d ' ' -f 1)

echo "Copying passwordfile /etc/bandit_pass/$myname to /tmp/$mytarget"

cat /etc/bandit_pass/$myname > /tmp/$mytarget
bandit22@bandit:/etc/cron.d$ cat /tmp/$(echo I am user bandit23 | md5sum | cut -d ' ' -f 1)

jc1udXuA1tiHqjIsL8yaapX5XIAI6i0n
```

# Level 23 - 24

A program is running automatically at regular intervals from cron, the time-based job scheduler. Look in /etc/cron.d/ for the configuration and see what command is being executed.

### Summary

Level23 requires us to write a small script that is run by the cron scheduler in order to read the next password. There are a couple things to note in this process. One, we need the script we write to be executable by bandit24. Also, we need the file the script outputs or appends to to be readable by bandit23 and writable by bandit24. This is shown by the following snippet:

```
chmod 777 $TEMP
chmod 666 $TEMP/23_pass.txt
```

Since cron wont give us much output and allow us to debug the script easily, we need to make sure we pay attention to the syntax and logic in the scripts.

### Solution(s)

```
bandit23@bandit:~$ cat /etc/cron.d/cronjob_bandit24
@reboot bandit24 /usr/bin/cronjob_bandit24.sh &> /dev/null
* * * * * bandit24 /usr/bin/cronjob_bandit24.sh &> /dev/null
bandit23@bandit:~$ cat /usr/bin/cronjob_bandit24.sh
#!/bin/bash

myname=$(whoami)

cd /var/spool/$myname
echo "Executing and deleting all scripts in /var/spool/$myname:"
for i in * .*;
do
    if [ "$i" != "." -a "$i" != ".." ];
    then
        echo "Handling $i"
        owner="$(stat --format "%U" ./$i)"
        if [ "${owner}" = "bandit23" ]; then
            timeout -s 9 60 ./$i
        fi
        rm -f ./$i
    fi
done

bandit23@bandit:~$ mkdir /tmp/my23folder && cd /tmp/my23folder
bandit23@bandit:/tmp/my23folder$ nano cron.sh
bandit23@bandit:/tmp/my23folder$ cat cron.sh
#!/bin/bash

TEMP='/tmp/boopbeep23'
PASSFILE='/etc/bandit_pass/bandit24'

if [ ! -d $TEMP ]; then
    mkdir $TEMP
fi

touch $TEMP/23_pass.txt
cat $PASSFILE > $TEMP/23_pass.txt

chmod 777 $TEMP
chmod 666 $TEMP/23_pass.txt
bandit23@bandit:/tmp/my23folder$ chmod 777 cron.sh
bandit23@bandit:/tmp/my23folder$ cp cron.sh /var/spool/bandit24/
bandit23@bandit:/tmp/my23folder$ ls -lah /var/spool/bandit24/cron.sh
-rwxr-xr-x 1 bandit23 bandit23 221 Jun 18 21:24 /var/spool/bandit24/cron.sh
bandit23@bandit:/tmp/my23folder$ ls /tmp/boopbeep23
23_pass.txt
bandit23@bandit:/tmp/my23folder$ cat /tmp/boopbeep23/23_pass.txt
UoMYTrfrBFHyQXmg6gzctqAwOmw1IohZ
```

# Level 24 - 25

A daemon is listening on port 30002 and will give you the password for bandit25 if given the password for bandit24 and a secret numeric 4-digit pincode. There is no way to retrieve the pincode except by going through all of the 10000 combinations, called brute-forcing.

### Summary

This was done a little different in order to script the solution. First, a 'password' list is generated and saved to a file. This file is then cat'd into a netcat connection and the output of that is added to the output.txt file. This allows us then to parse the output file using the 'sort' and 'uniq' commands to remove all the 'Wrong!' lines.

We then add some additional parsing to the commands to clean up the output and we have the next level's password.

### Solution(s)

```
bandit24@bandit:~$ mkdir /tmp/mytempdir24
bandit24@bandit:~$ cd /tmp/mytempdir24
bandit24@bandit:/tmp/mytempdir24$ touch myListOf.txt
bandit24@bandit:/tmp/mytempdir24$ for i in {0000..9999}; do echo 'UoMYTrfrBFHyQXmg6gzctqAwOmw1IohZ' $(printf "%04d" $i) >> myListOf.txt; done;
bandit24@bandit:/tmp/mytempdir24$ cat myListOf.txt | nc localhost 30002 >> output.txt
bandit24@bandit:/tmp/mytempdir24$ head output.txt
I am the pincode checker for user bandit25. Please enter the password for user bandit24 and the secret pincode on a single line, separated by a space.
Wrong! Please enter the correct pincode. Try again.
Wrong! Please enter the correct pincode. Try again.
Wrong! Please enter the correct pincode. Try again.
Wrong! Please enter the correct pincode. Try again.
Wrong! Please enter the correct pincode. Try again.
Wrong! Please enter the correct pincode. Try again.
Wrong! Please enter the correct pincode. Try again.
Wrong! Please enter the correct pincode. Try again.
Wrong! Please enter the correct pincode. Try again.
bandit24@bandit:/tmp/mytempdir24$ sort output.txt | uniq -u

Correct!
Exiting.
I am the pincode checker for user bandit25. Please enter the password for user bandit24 and the secret pincode on a single line, separated by a space.
The password of user bandit25 is uNG9O58gUE7snukf3bvZ0rxhtnjzSGzG
bandit24@bandit:/tmp/mytempdir24$ sort output.txt | uniq -u | grep password
I am the pincode checker for user bandit25. Please enter the password for user bandit24 and the secret pincode on a single line, separated by a space.
The password of user bandit25 is uNG9O58gUE7snukf3bvZ0rxhtnjzSGzG
bandit24@bandit:/tmp/mytempdir24$ sort output.txt | uniq -u | awk '{print $NF}'

Correct!
Exiting.
space.
uNG9O58gUE7snukf3bvZ0rxhtnjzSGzG
bandit24@bandit:/tmp/mytempdir24$ sort output.txt | uniq -u | awk '{print $NF}' | tail -n -1
uNG9O58gUE7snukf3bvZ0rxhtnjzSGzG
```

# Level 25 - 27

Logging in to bandit26 from bandit25 should be fairly easy??? The shell for user bandit26 is not /bin/bash, but something else. Find out what it is, how it works and how to break out of it.

### Summary

This level is a pain because it relies on the behavior of the 'more' command. This command allows you to print data to the screen--similar to cat, less, tail, head--but will page the data if it is too long to fit on one screen. This means that if the text within the associated file is too long, it will give you the ability to scroll down through the file. While in this scrolling mode, we have additional capabilities like openning shells and entering an edit mode.

So, the first step is logging into the server while the screen is small enough to force 'more' to page the data. Once the paging has started and you have an interactive screen, we can set the shell to something more useful, and run our own bash shell.

### Solution(s)

1. Make window small
2. Press v
3. Set shell
```
:set shell=/bin/bash
```
4. Run shell
```
~/text.txt[RO] [dec= 95] [hex=5F] [pos=0001:0003][16% of 6]
:shell
bandit26@bandit:~$ cat /etc/bandit_pass/bandit26
5czgV9L3Xx8JPOyRbXh6lQbmIOWvPT6Z
bandit26@bandit:~$ ls
bandit27-do  text.txt
bandit26@bandit:~$ ./bandit27-do cat /etc/bandit_pass/bandit27
3ba3118a22e93127a4ed485be72ef5ea
bandit26@bandit:~$
```

# Level 27 - 28

There is a git repository at ssh://bandit27-git@localhost/home/bandit27-git/repo. The password for the user bandit27-git is the same as for the user bandit27.

### Summary

Introducing...... GIT! Git is a version control application that tracks changes across a project or directory. Git repositories can be stored on git servers and allow users to download or 'clone' the repository along with the history of changes.

For this level, we have to clone the specified repository and read the file within the repo.

After the repo is clone and we see the 'README' file, we can clean up the output with another awk command.

### Solution(s)

```
bandit27@bandit:~$ ls
bandit27@bandit:~$ mkdir /tmp/my27gitdir && cd /tmp/my27gitdir
bandit27@bandit:/tmp/my27gitdir$ git clone ssh://bandit27-git@localhost/home/bandit27-git/repo
Cloning into 'repo'...
Could not create directory '/home/bandit27/.ssh'.
The authenticity of host 'localhost (127.0.0.1)' can't be established.
ECDSA key fingerprint is SHA256:98UL0ZWr85496EtCRkKlo20X3OPnyPSB5tB5RPbhczc.
Are you sure you want to continue connecting (yes/no)? yes
Failed to add the host to the list of known hosts (/home/bandit27/.ssh/known_hosts).
This is a OverTheWire game server. More information on http://www.overthewire.org/wargames

bandit27-git@localhost's password:
remote: Counting objects: 3, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (3/3), done.
bandit27@bandit:/tmp/my27gitdir$ ls
repo
bandit27@bandit:/tmp/my27gitdir$ cd repo
bandit27@bandit:/tmp/my27gitdir/repo$ ls
README
bandit27@bandit:/tmp/my27gitdir/repo$ cat README
The password to the next level is: 0ef186ac70e04ea33b4c1853d2526fa2
bandit27@bandit:/tmp/my27gitdir/repo$
bandit27@bandit:/tmp/my27gitdir/repo$ cat README | awk '{print $NF}'
0ef186ac70e04ea33b4c1853d2526fa2
```

# Level 28 - 29

There is a git repository at ssh://bandit28-git@localhost/home/bandit28-git/repo. The password for the user bandit28-git is the same as for the user bandit28.

Clone the repository and find the password for the next level.

### Summary

Starting with the clone process, we download the repo and start exploring. We see notes in the 'README.md' file that the password has been redacted. To see if this has always been the case, we can view the log of changes. Using the 'git log -p' command, we can see all the patches/changes to the files. Within the changes, we see that the password did exist but was changed.

This is an IMPORTANT lesson to be learned. Don't push information to git repositories that shouldn't be public or read by others! Git histories are hard to 'clean' and data tends to persist for longer than many realize.

### Solution(s)

```
bandit28@bandit:~$ mkdir /tmp/my28tempfolder && cd /tmp/my28tempfolder && git clone ssh://bandit28-git@localhost/home/bandit28-git/repo
Cloning into 'repo'...
Could not create directory '/home/bandit28/.ssh'.
The authenticity of host 'localhost (127.0.0.1)' can't be established.
ECDSA key fingerprint is SHA256:98UL0ZWr85496EtCRkKlo20X3OPnyPSB5tB5RPbhczc.
Are you sure you want to continue connecting (yes/no)? yes
Failed to add the host to the list of known hosts (/home/bandit28/.ssh/known_hosts).
This is a OverTheWire game server. More information on http://www.overthewire.org/wargames

bandit28-git@localhost's password:
remote: Counting objects: 9, done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 9 (delta 2), reused 0 (delta 0)
Receiving objects: 100% (9/9), done.
Resolving deltas: 100% (2/2), done.
bandit28@bandit:/tmp/my28tempfolder$ ls
repo
bandit28@bandit:/tmp/my28tempfolder$ cd repo/
bandit28@bandit:/tmp/my28tempfolder/repo$ ls
README.md
bandit28@bandit:/tmp/my28tempfolder/repo$ cat README.md
# Bandit Notes
Some notes for level29 of bandit.

## credentials

- username: bandit29
- password: xxxxxxxxxx

bandit28@bandit:/tmp/my28tempfolder/repo$ git log -p
commit edd935d60906b33f0619605abd1689808ccdd5ee
Author: Morla Porla <morla@overthewire.org>
Date:   Thu May 7 20:14:49 2020 +0200

    fix info leak

diff --git a/README.md b/README.md
index 3f7cee8..5c6457b 100644
--- a/README.md
+++ b/README.md
@@ -4,5 +4,5 @@ Some notes for level29 of bandit.
 ## credentials

 - username: bandit29
-- password: bbc96594b4e001778eee9975372716b2
+- password: xxxxxxxxxx


commit c086d11a00c0648d095d04c089786efef5e01264
Author: Morla Porla <morla@overthewire.org>
Date:   Thu May 7 20:14:49 2020 +0200

bandit28@bandit:/tmp/my28tempfolder/repo$ git log -p | grep password
-- password: bbc96594b4e001778eee9975372716b2
+- password: xxxxxxxxxx
-- password: <TBD>
+- password: bbc96594b4e001778eee9975372716b2
+- password: <TBD>
bandit28@bandit:/tmp/my28tempfolder/repo$ git log -p | grep password | head -n 1 | awk '{print $NF}'
bbc96594b4e001778eee9975372716b2
```

# Level 29 - 30

There is a git repository at ssh://bandit29-git@localhost/home/bandit29-git/repo. The password for the user bandit29-git is the same as for the user bandit29

### Summary

We again clone the repo and start exploring. We see a hidden file that leads us to believe there are other versions of the code. In git, this is done through 'branches' and allows a project to have different versions. To view the different versions or branches, we can use the 'git branch -a' command. Once we see a branch we want to checkout, we can 'checkout' the branch and change our local codebase to that specific version. 

### Solution(s)

```
bandit29@bandit:~$ mkdir /tmp/my29tempfolder && cd /tmp/my29tempfolder && git clone ssh://bandit29-git@localhost/home/bandit29-git/repo
Cloning into 'repo'...
Could not create directory '/home/bandit29/.ssh'.
The authenticity of host 'localhost (127.0.0.1)' can't be established.
ECDSA key fingerprint is SHA256:98UL0ZWr85496EtCRkKlo20X3OPnyPSB5tB5RPbhczc.
Are you sure you want to continue connecting (yes/no)? yes
Failed to add the host to the list of known hosts (/home/bandit29/.ssh/known_hosts).
This is a OverTheWire game server. More information on http://www.overthewire.org/wargames

bandit29-git@localhost's password:
remote: Counting objects: 16, done.
remote: Compressing objects: 100% (11/11), done.
Receiving objects: 100% (16/16), 1.43 KiB | 0 bytes/s, done.
remote: Total 16 (delta 2), reused 0 (delta 0)
Resolving deltas: 100% (2/2), done.
bandit29@bandit:/tmp/my29tempfolder$ ls
repo
bandit29@bandit:/tmp/my29tempfolder$ cd repo
bandit29@bandit:/tmp/my29tempfolder/repo$ ls -lah
total 16K
drwxr-sr-x 3 bandit29 root 4.0K Jun 20 00:13 .
drwxr-sr-x 3 bandit29 root 4.0K Jun 20 00:13 ..
drwxr-sr-x 8 bandit29 root 4.0K Jun 20 00:13 .git
-rw-r--r-- 1 bandit29 root  131 Jun 20 00:13 README.md
bandit29@bandit:/tmp/my29tempfolder/repo$ cat README.md
# Bandit Notes
Some notes for bandit30 of bandit.

## credentials

- username: bandit30
- password: <no passwords in production!>

bandit29@bandit:/tmp/my29tempfolder/repo$ git branch -a
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/dev
  remotes/origin/master
  remotes/origin/sploits-dev
bandit29@bandit:/tmp/my29tempfolder/repo$ git checkout dev
Branch dev set up to track remote branch dev from origin.
Switched to a new branch 'dev'
bandit29@bandit:/tmp/my29tempfolder/repo$ ls
code  README.md
bandit29@bandit:/tmp/my29tempfolder/repo$ git log -p | grep password
-- password: <no passwords in production!>
+- password: 5b90576bedb2cc04c86a9e924ce42faf
 - password: <no passwords in production!>
+- password: <no passwords in production!>
bandit29@bandit:/tmp/my29tempfolder/repo$ git log -p | grep password | head -n 2 | tail -n 1
+- password: 5b90576bedb2cc04c86a9e924ce42faf
bandit29@bandit:/tmp/my29tempfolder/repo$ git log -p | grep password | head -n 2 | tail -n 1 | awk '{print $NF}'
5b90576bedb2cc04c86a9e924ce42faf
```

# Level 30 - 31

There is a git repository at ssh://bandit30-git@localhost/home/bandit30-git/repo. The password for the user bandit30-git is the same as for the user bandit30.

### Summary

Level30 introduces tags which are named commits of a repository. This means that you can name a specific commit for releases, different versions, or a specific state of the application. For example, tag a specific commit 'v1.5' to specify that version was released as version 1.5 This allows you to track versions and roll-back changes if needed.

To view tags, we can use the 'git tag' and 'git show' commands.

### Solution(s)

```
bandit30@bandit:~$ mkdir /tmp/my30tempfolder && cd /tmp/my30tempfolder && git clone ssh://bandit30-git@localhost/home/bandit30-git/repo
mkdir: cannot create directory ???/tmp/my30tempfolder???: File exists
bandit30@bandit:~$ rm -f /tmp/my30tempfolder
rm: cannot remove '/tmp/my30tempfolder': Is a directory
bandit30@bandit:~$ rm -r /tmp/my30tempfolder
bandit30@bandit:~$ mkdir /tmp/my30tempfolder && cd /tmp/my30tempfolder && git clone ssh://bandit30-git@localhost/home/bandit30-git/repo
Cloning into 'repo'...
Could not create directory '/home/bandit30/.ssh'.
The authenticity of host 'localhost (127.0.0.1)' can't be established.
ECDSA key fingerprint is SHA256:98UL0ZWr85496EtCRkKlo20X3OPnyPSB5tB5RPbhczc.
Are you sure you want to continue connecting (yes/no)? yes
Failed to add the host to the list of known hosts (/home/bandit30/.ssh/known_hosts).
This is a OverTheWire game server. More information on http://www.overthewire.org/wargames

bandit30-git@localhost's password:
remote: Counting objects: 4, done.
remote: Total 4 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (4/4), done.
bandit30@bandit:/tmp/my30tempfolder$ ls
repo
bandit30@bandit:/tmp/my30tempfolder$ cd repo
bandit30@bandit:/tmp/my30tempfolder/repo$ ls
README.md
bandit30@bandit:/tmp/my30tempfolder/repo$ cat README.md
just an epmty file... muahaha
bandit30@bandit:/tmp/my30tempfolder/repo$ git log -p
commit 3aefa229469b7ba1cc08203e5d8fa299354c496b
Author: Ben Dover <noone@overthewire.org>
Date:   Thu May 7 20:14:54 2020 +0200

    initial commit of README.md

diff --git a/README.md b/README.md
new file mode 100644
index 0000000..029ba42
--- /dev/null
+++ b/README.md
@@ -0,0 +1 @@
+just an epmty file... muahaha
bandit30@bandit:/tmp/my30tempfolder/repo$ git branch -a
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/master
bandit30@bandit:/tmp/my30tempfolder/repo$ grep -r "password" ./.git
bandit30@bandit:/tmp/my30tempfolder/repo$ ls -lah
total 16K
drwxr-sr-x 3 bandit30 root 4.0K Jun 20 00:18 .
drwxr-sr-x 3 bandit30 root 4.0K Jun 20 00:18 ..
drwxr-sr-x 8 bandit30 root 4.0K Jun 20 00:18 .git
-rw-r--r-- 1 bandit30 root   30 Jun 20 00:18 README.md
bandit30@bandit:/tmp/my30tempfolder/repo$ cd .git
bandit30@bandit:/tmp/my30tempfolder/repo/.git$ ls
branches  config  description  HEAD  hooks  index  info  logs  objects  packed-refs  refs
bandit30@bandit:/tmp/my30tempfolder/repo/.git$ cat description
Unnamed repository; edit this file 'description' to name the repository.
bandit30@bandit:/tmp/my30tempfolder/repo/.git$ cat config
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[remote "origin"]
	url = ssh://bandit30-git@localhost/home/bandit30-git/repo
	fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
	remote = origin
	merge = refs/heads/master
bandit30@bandit:/tmp/my30tempfolder/repo/.git$ grep -irn "password" ./
bandit30@bandit:/tmp/my30tempfolder/repo/.git/info$ git tag
secret
bandit30@bandit:/tmp/my30tempfolder/repo/.git/info$ git show secret
47e603bb428404d265f59c42920d81e5
```

# Level 31 - 32

There is a git repository at ssh://bandit31-git@localhost/home/bandit31-git/repo. The password for the user bandit31-git is the same as for the user bandit31.

Clone the repository and find the password for the next level.

### Summary

One of the last important Git concepts is commits and pushes. To introduce changes to a project/repository, you can commit changes, and push them to the remote repository. Commits are just groupings of changes that can have associated messages and are introduced to the repository with a 'push'. Other users can then pull changes from the remote into their local system with the 'pull' command.

Once a change is introduced or a file is added, they can be tracked with the add command. This can also be done with the '-a' flag in the commit command.

### Solution(s)

```
bandit31@bandit:~$ mkdir /tmp/my31tempfolder && cd /tmp/my31tempfolder && git clone ssh://bandit31-git@localhost/home/bandit31-git/repo && cd repo
Cloning into 'repo'...
Could not create directory '/home/bandit31/.ssh'.
The authenticity of host 'localhost (127.0.0.1)' can't be established.
ECDSA key fingerprint is SHA256:98UL0ZWr85496EtCRkKlo20X3OPnyPSB5tB5RPbhczc.
Are you sure you want to continue connecting (yes/no)? yes
Failed to add the host to the list of known hosts (/home/bandit31/.ssh/known_hosts).
This is a OverTheWire game server. More information on http://www.overthewire.org/wargames

bandit31-git@localhost's password:
remote: Counting objects: 4, done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 4 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (4/4), done.
bandit31@bandit:/tmp/my31tempfolder/repo$ cat README.md
This time your task is to push a file to the remote repository.

Details:
    File name: key.txt
    Content: 'May I come in?'
    Branch: master

bandit31@bandit:/tmp/my31tempfolder/repo$ echo "May I come in?" > key.txt
bandit31@bandit:/tmp/my31tempfolder/repo$ git add key.txt
The following paths are ignored by one of your .gitignore files:
key.txt
Use -f if you really want to add them.
bandit31@bandit:/tmp/my31tempfolder/repo$ git add -f key.txt
bandit31@bandit:/tmp/my31tempfolder/repo$ git commit -a -m "Add key"
[master d5c9507] Add key
 1 file changed, 1 insertion(+)
 create mode 100644 key.txt
bandit31@bandit:/tmp/my31tempfolder/repo$ git push
Could not create directory '/home/bandit31/.ssh'.
The authenticity of host 'localhost (127.0.0.1)' can't be established.
ECDSA key fingerprint is SHA256:98UL0ZWr85496EtCRkKlo20X3OPnyPSB5tB5RPbhczc.
Are you sure you want to continue connecting (yes/no)? yes
Failed to add the host to the list of known hosts (/home/bandit31/.ssh/known_hosts).
This is a OverTheWire game server. More information on http://www.overthewire.org/wargames

bandit31-git@localhost's password:
Counting objects: 3, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 319 bytes | 0 bytes/s, done.
Total 3 (delta 0), reused 0 (delta 0)
remote: ### Attempting to validate files... ####
remote:
remote: .oOo.oOo.oOo.oOo.oOo.oOo.oOo.oOo.oOo.oOo.
remote:
remote: Well done! Here is the password for the next level:
remote: 56a9bf19c63d650ce78e6ec0354ee45e
remote:
remote: .oOo.oOo.oOo.oOo.oOo.oOo.oOo.oOo.oOo.oOo.
remote:
To ssh://localhost/home/bandit31-git/repo
 ! [remote rejected] master -> master (pre-receive hook declined)
error: failed to push some refs to 'ssh://bandit31-git@localhost/home/bandit31-git/repo'
```

# Level 32 - 33

After all this git stuff its time for another escape. Good luck!

### Summary

Bash has a variety of built in variables. One of those variables is the current shell for the user. This can be retrieved with the '$0' variable. This challenge can be completed by typing '$0' which runs the /bin/sh shell which allows you to 'escape' from the current uppercase shell.

Some other common variables are '$BASH' for the path to the bash binary, '$CDPATH' for the cd search paths, '$PATH' for the search paths for binaries, '$HOME' for the current users home directory, '$0, $1, $2, ...' for positional parameters passed in from the command line to a script, '$?' for the exit status of the previous command, and '$$' for the current process ID (PID).

### Solution(s)

```
WELCOME TO THE UPPERCASE SHELL
>> $0
$ echo $0
sh
$ cat /etc/bandit_pass/bandit33
c9c3199ddf4121b10cf581a98d51caee
```