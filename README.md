# tools

This project contains useful tools to improve my work. :)

Documentation
=============

Table of contents
-----------------

1. [Add ssh key to remote linux machine](#add_ssh_key)
2. [Add virtual host in Apache](#add_virtual_host_apache)
3. [Add virtual host in Nginx](#add_virtual_host_nginx)

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

<a name="add_virtual_host_apache"></a>
Add Virtual Host in Apache
--------------------------

This script creates localhost website folder and adds virtual domain with sufix .lh

###Remember###

Before run this script You must create config.sh file from config.sh.default! This file is in folder: *bash/AddVirtualHostApache/*

###Example###

Run this command

```bash
sudo bash/AddVirtualHostApache/addVirtualHostApache.sh test
```

will create local domain test.lh. 

After this script You can enter browser and write adress test,lh and You will see "hello test!" on screen. :)

<a name="add_virtual_host_nginx"></a>
Add Virtual Host in Nginx
--------------------------

This script creates localhost website folder and adds virtual domain with sufix .lh

###Remember###

Before run this script You must create config.sh file from config.sh.default! This file is in folder: *bash/AddVirtualHostNginx/*

###Example###

Run this command

```bash
sudo bash/AddVirtualHostApache/addVirtualHostNginx.sh test
```

will create local domain test.lh. 

After this script You can enter browser and write adress test,lh and You will see "hello test!" on screen. :)

