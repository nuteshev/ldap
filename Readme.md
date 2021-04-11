Работа: 
```
vagrant up ipaserver
vagrant up ipaclient
```

Для того, чтобы проверить работу аутентификации по SSH-ключам, следует для нужного пользователя (здесь это admin) выполнить следующие действия
(после приглашения "Password for admin@OTUS.LOCAL:" я ввёл пароль Secret456). 
```
[root@ipaclient ~]# su - admin
Last login: Sun Apr 11 20:49:11 UTC 2021 on pts/0
[admin@ipaclient ~]$ ssh-keygen -C admin@otus.local
Generating public/private rsa key pair.
Enter file in which to save the key (/home/admin/.ssh/id_rsa):
Created directory '/home/admin/.ssh'.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/admin/.ssh/id_rsa.
Your public key has been saved in /home/admin/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:xkziMnnuupXsNXRhkBuFxMAA2iCyRcV2SjlHGqRO0Xg admin@otus.local
The key's randomart image is:
+---[RSA 3072]----+
|+.=B==o+o+.      |
|o*.oEo+ =.       |
|o ++.=. .oo      |
| o  .o =.. .     |
|  . + o S .      |
|     * + .       |
|      = o        |
|     + . .       |
|    ooo          |
+----[SHA256]-----+
[admin@ipaclient ~]$ kinit admin
Password for admin@OTUS.LOCAL:
[admin@ipaclient ~]$ ipa user-mod admin --sshpubkey="$(cat /home/admin/.ssh/id_rsa.pub)"
---------------------
Modified user "admin"
---------------------
  User login: admin
  Last name: Administrator
  Home directory: /home/admin
  Login shell: /bin/bash
  Principal alias: admin@OTUS.LOCAL
  UID: 1061600000
  GID: 1061600000
  SSH public key: ssh-rsa
                  AAAAB3NzaC1yc2EAAAADAQABAAABgQC3mSj6it4LxQ3HIjatss2wm6b2FvqqT/lUBvzgJ8De/FCR0JsK/8yLHPMwgk4IUBMMdMN7Ca0FjVmHy1qPJTe8hLTfoAIGuM4qPRJFppmc61sOv1dKRo4G1r33PMTJkyPfFklsacn/OtiRuBZvHYCWDW+l462APHEwooqxymLvZmNrSJIGoyiPUtvwRD1LNmZAzSXZZgTRzd7MtbrarJQu4fWtsdO2/wrf80COZ2B+Ok9VrjcxBGOiUJRCPBiLRBJfcKT/cWTfs+1n0YoO1tWdhx9njJt/jW7DZHqx7Qaayc1y5yTwMRqclsnbnPyWB5QsB58DnPisPqesXV88A4yQ+cDFIc7sGry6Tdt93mTieyO3r2xqD5nOyPyblGEeB5+6Hk7n42TMzedLTZBdDg+cNfl+Qmg2A6yj3fsxEqmGUcYlzEWesli3NRvjEkcaVP3+A73XiudnW0obd33EYt8YzjZwutUMV12rfcglsHoa/ZBLgFLe43JxRTsOlO+5EjM=
                  admin@otus.local
  SSH public key fingerprint: SHA256:xkziMnnuupXsNXRhkBuFxMAA2iCyRcV2SjlHGqRO0Xg admin@otus.local (ssh-rsa)
  Account disabled: False
  Password: True
  Member of groups: admins, trust admins
  Kerberos keys available: True
[admin@ipaclient ~]$ ssh -o GSSAPIAuthentication=no freeipa.otus.local
Could not chdir to home directory /home/admin: No such file or directory
[admin@freeipa /]$
```

Как видим, я успешно залогинился на сервере. 