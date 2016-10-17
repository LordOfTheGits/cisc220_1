#!/bin/bash

((x=2))
var=$(ifconfig | head -n2 | tail -n1)

while ( [ ! -z "$var" ] ) ; do

    numb=${var:20}
    space=$(expr index "$numb" \ )
    ip=${numb:0:space}
    first=${ip:0:3}
    second=${ip:0:7}

    if [[ $first == "127" ]] ;
        then echo  "Local IP" ;
    elif [[ $first == "10." || $second == "192.168" ]] ; then
        echo "Private IP" ;
    else echo "Public IP" ;
    fi

((x=x+9))
var=$(ifconfig | head -n$x | tail -n1)

done