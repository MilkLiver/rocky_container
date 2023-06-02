# rocky_container
rocky linux 9.1 with xrdp, ssh and systemd



### build docker image

```
docker build -t imagename . 
```

### run image

username => create user name

password => create user password

mod => is sudo user? yes|no)

```
docker run --name rdpssh -e "username=<user name>" -e "password=<user password>" -e "mod=<yes|no>" -idt -p<host mapping rdp port>:3389 -p<host mapping ssh port>:22 <image>
```

like this

``````
docker run --name rdpssh -e "username=admin" -e "password=Admin12345" -e "mod=yes" -idt -p13389:3389 -p10022:22 
``````