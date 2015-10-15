# tools

This project contains useful tools to improve my work. :)

Documentation
=============

Table of contents
-----------------

1. [Add ssh key to remote linux machine](#add_ssh_key)

<a name="add_shh_key"></a>
Add ssh key to remote linux machine
-----------------------------------

This script send and add your public SSH Key to Remote Server.

###Example###

```bash
bash/AddSshKey/addSshKey.sh marceen 123.123.123.123 222
```

**variables:**
- *marceen* - username
- *123.123.123.123* - hostname
- *222* - port

If remote server (or your machine) doesn't have ~/.ssh folder You can create it by command:

```bash
ssh-keygen -t rsa
```
