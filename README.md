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


Server SSH access
=================
To add an admin's ssh credentials follow the these steps:

1. Add your ssh public key in the folder ssh_pub_keys/your_name.pub
2. Install your ssh key on the host machine by rerunning the setup server recipe in ansible.
3. Test if your user has access by running the following ansible commands amd verify the output is correct:
     ```bash,
     # ansible all -i inv.ini -m ping -u root
     x.x.x.x | success >> {
        "changed": false,
        "ping": "pong"
     }
     ```
All done!
