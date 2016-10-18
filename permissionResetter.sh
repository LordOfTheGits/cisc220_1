#!/bin/bash
if [[ $1 == '-r' ]]; then
	fileName=''
	permissions=''
	i=0
	for line in $(cat $2) ; do
		if (($i%2 == 0)) ; then
			permissions=$line
		else
			j=1
			k=0
			var=(0 0 0)
			fileName=$line
			while [[ j -lt 10 ]]; do
				pos=$(($(($j-1))%3))

				if [[ ${permissions:j:1} == 'r' ]] ; then
					var[$k]=$((${var[$k]}+4))
				fi
				if [[ ${permissions:j:1} == 'w' ]] ; then
					var[$k]=$((${var[$k]}+2))
				fi
				if [[ ${permissions:j:1} == 'x' ]] ; then
					var[$k]=$((${var[$k]}+1))
				fi
				j=$(($j+1))

				case $j in
					[1-3])
					k=0
					;;
					[4-6])
					k=1
					;;
					[7-9])
					k=2
					;;
				esac
			done
			chmod ${var[0]}${var[1]}${var[2]} $fileName
		fi
		i=$((i+1))
	done
elif [[ $1 == "-s" ]] ; then

    old=$2
    changed=newFile
    ls -l * | awk '{print $1" " $9}' > $changed
    rows=$(wc $changed | awk '{print $1}')

    for (( x=1 ; x<=rows ; x++)) ; do

        line1=$(head -n$x $old | tail -n1)
        file=${line1:11}#file name
        line1=${line1:0:10}#old permissions of the file
        line2=$(head -n$x $changed | tail -n1)
        line2=${line2:0:10}#current permissions of the file

        #this if statement isn't working for some reason, all comparision are considered true
        if [[ ! line1 == line2 ]] ; then

            if (( x == 1 )) ; then
                echo "Old            Current        File"
            fi

        echo "$line1     $line2     $file"
        fi

    done
else
	echo invalid argument: $1
fi
