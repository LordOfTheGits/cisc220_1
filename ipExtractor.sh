#!/bin/bash

((x=2))

#var is the current line with an IP address to be classified
var=$(ifconfig | head -n2 | tail -n1)

#goes through ifconfig until there are no more IP addresses to classify
while ( [ ! -z "$var" ] ) ; do

    numb=${var:20}
    space=$(expr index "$numb" \ )
    ip=${numb:0:space}#contains the IP address
    first=${ip:0:3}#contains first three characters of IP address, will help classify them
    second=${ip:0:7}#contains first 7 characters of the IP address

    #if statement for if the IP is local
    if [[ $first == "127" ]] ;
        then echo  "$ip Local IP" ;
    #other cases for if it's a private IP
    elif [[ $first == "10." || $second == "192.168" ]] ; then
        echo "$ip Private IP" ;
    #else it's a public IP
    else echo "$ip Public IP" ;

    fi

#the IP addresses in ifconfig are every 9 liness so this help go to the next one
((x=x+9))
#sets up var to be the next line with an IP address
var=$(ifconfig | head -n$x | tail -n1)

done