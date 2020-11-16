#!/bin/bash
#$email='p@dummy.com'

read -p "Nome Utente: " uname
read -p "password utente da creare: " password
read -p "email utente da creare: " email
read -p "Inserire indirizzo IP della CVM: " cvmip

#creazione primo utente
echo "/home/nutanix/prism/cli/ncli user add user-name=$uname user-password=$password first-name='usr'$uname last-name='usr'$uname email-id=$email" > script.tmp
echo "/home/nutanix/prism/cli/ncli user  grant-user-admin-role user-name=$uname" >> script.tmp

#creazione utenti BULK 0-5
echo " "
read -p "Vuoi creare utenti LAB? (s/n): " scelta1


if [ $scelta1 == 's' ];
then
  read -p "Quanti utenti vuoi creare?: " scelta2
  for (( i=1; i<=$scelta2; i++ ))
    do
        echo "/home/nutanix/prism/cli/ncli user add user-name=ntnxuser$i user-password=nutanix/4u first-name='usr'$i last-name='usr'$i email-id=p@p.com" >> script.tmp
        echo "/home/nutanix/prism/cli/ncli user  grant-user-admin-role user-name=ntnxuser$i" >> script.tmp
    done
fi
#execute script
ssh nutanix@$cvmip "bash -s" < ./script.tmp
