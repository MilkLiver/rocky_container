#!/bin/bash

start_xrdp_services() {
    # Preventing xrdp startup failure
    rm -rf /var/run/xrdp-sesman.pid
#    rm -rf /var/run/ibus-daemon.pid
    rm -rf /var/run/xrdp.pid
    rm -rf /var/run/xrdp/xrdp-sesman.pid
    rm -rf /var/run/xrdp/xrdp.pid
#    ibus-daemon -d 

    # Use exec ... to forward SIGNAL to child processes
    xrdp-sesman 
    exec xrdp -n
}

stop_xrdp_services() {
    #ibus-daemon --kill
    xrdp --kill
    xrdp-sesman --kill
    exit 0
}

echo Entryponit script is Running...
echo

#users=$(($#/3))
#mod=$(($# % 3))

echo "root:$root_password" | chpasswd

echo "users is $username"
echo "mod is $mod"

#if [[ $# -eq 0 ]]; then
#    echo "No input parameters. exiting..."
#    echo "there should be 3 input parameters per user"
#    exit
#fi
#
#if [[ $mod -ne 0 ]]; then
#    echo "incorrect input. exiting..."
#    echo "there should be 3 input parameters per user"
#    exit
#fi
echo "You entered $username users"

#while [ $# -ne 0 ]; do

    echo "username is $username"
    useradd $username
    wait
    #getent passwd | grep foo
    echo $username:$password | chpasswd
    wait
    echo "sudo is $mod"
    if [[ $mod == "yes" ]]; then
        usermod -aG wheel $username
    fi
    wait
    echo "user '$username' is added"

    echo "$(cat /xsessionrc)" >> "home/$username/.bashrc"
    #cp /xsessionrc "/home/$username/.xinitrc"
    #chown $username:$username "/home/$username/.xinitrc"
    # Shift all the parameters down by three
    shift 3
#done


#echo "start sshd on $ssh_port"
#/usr/sbin/sshd -p $ssh_port

echo -e "This script is ended\n"

echo -e "starting xrdp services...\n"

#trap "stop_xrdp_services" SIGKILL SIGTERM SIGHUP SIGINT EXIT
#start_xrdp_services

systemctl enable xrdp

exec /usr/sbin/init
