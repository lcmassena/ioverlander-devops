iOverlander.com DevOps scripts and information repository
---------------------------------------------------------

To keep costs down as much as possible the entire infrastructure is run on one 
kimsufi dedicated server. The system is set up with Ubuntu Server 16.04 "Xenial 
Xerus" provided by kimsufi. On top of that a basic firewall is configured, SSH
access secured and Docker installed.

All services needed to run the app are launched as individual docker containers. 
Both a staging & production environment are hosted on this server.


Contributing
============
iOverland is a volunteer driven projects. We raise the funds needed to run our 
infrastructure from our users, publish our code under an opensource license. 

iOverlander.com wouldn't exist without the thousands of travelers checking in, 
adding new places and maintaining our data. iOverlander wouldn't be possible
without your help in development of this site either. If you'd like to con-
tribute in any way, feel free to reach out to us!


Prerequisites
=============
1. Install ansible on your computer (`sudo pip install -g ansible`)
2. Sign up for a docker.com account if you need to administer container 
   repositories.
3. Github & Circle CI are used for our continuos integration. Get familiar 
   with these tools.
4. You need to obtain the vault password for our secrets from another team member in a secure way.


List of repositories & docker images
====================================
The following repositories are maintained by us and run in production:

* ioverlander-devops: a collection of devops scripts & resources for setting 
     up & maintaining our servers 
* ioverlander-server: the new node.js powered app that is running everything 
     on www.ioverlander.com
* ioverlander-legacy-rails: the legacy rails app that runs our mobile API.


Setting up a new server
=======================
The server_setup.yml playbook is followed to setup the server initially. This script 
configures SSH and changes root & deploy user passwords. It will need to be executed 
with special settings because it assumes root access at first.

1. If you need to deploy to a new server, change the inv_setup.ini to the new IP.
2. Make sure that you have a valid ssh key in the public keys folder
3. Run the ansible playbook with the root user:
   ```
   ansible-playbook -i inv.ini server_configuration.yml --vault-password-file=.vault_pwd -e@vars/secrets.yml --ask-pass -u root
   ```

If at a later point you need to rerun part of the script when the deploy user is already
set up, you can run the playbook with these options:

```
ansible-playbook -i inv.ini server_configuration.yml --vault-password-file=.vault_pwd -e@vars/secrets.yml -b --ask-pass -K -u deploy
```


Updating Server SSH access
=================
To add an admin's ssh credentials follow the these steps:

1. Add the ssh public key to `vars/globals.yml`
3. Install your ssh key on the host machine by rerunning the `update_ssh_keys` playbook in ansible. 
   NB: You need to do this from a host that already has access.
     ```bash,
     $ ansible-playbook -i inv.ini update_ssh_keys.yml --vault-password-file=.vault_pwd -e@vars/secrets.yml
     ```
4. Test if your user has access by running the following ansible commands amd verify the output is correct:
     ```bash,
     $ ansible all -i inv.ini -m ping -u root
     x.x.x.x | success >> {
        "changed": false,
        "ping": "pong"
     }
     ```


Editing secrets
===============
All secrets are stored in ansible's vault. You need to obtain the password for the vault from another 
iOverlander contributor. Add the password to the `.vault_pwd` file. You can then edit the vault by running:

```
ansible-vault  --vault-password-file=.vault_pwd edit vars/secrets.yml 
```


Running an ansible script
=========================
There are a number of ansibe playbooks in this repo:

* `update_ssh_keys.yml`: Updates the ssh public keys. Execute this whenver you need to grant or revoke ssh access to the server.
* `deploy_app.yml`: Deploys the newest version of all the app containers. 
* `container_setup.yml`: Sets up docker networking, the load balancer and a few other things

```
ansible-playbook -i inv.ini container_setup.yml --vault-password-file=.vault_pwd -e@vars/secrets.yml
```


