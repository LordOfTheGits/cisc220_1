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
fi