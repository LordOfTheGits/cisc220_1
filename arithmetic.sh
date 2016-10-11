#!/bin/bash
result=0
num=""
firstrun=1
while [[ true ]]; do
	badNum=0
	read -p "Enter a number" num
	if [ ${#num} -eq 0 ]; then
		echo error
		continue
	fi
	if [ $num == ':q' ]; then
		break
	fi
	for (( i = 0; i < ${#num}; i++ )); do
		case ${num:$i:1} in
			[0-9])
				;;
			*)
				echo error
				badNum=1
				break
				;;
		esac
	done
	if [ $badNum -eq 1 ]; then
		badNum=0
		continue
	fi
	if [ $firstrun -eq 1 ]; then
		result=$num
		firstrun=0
		continue
	fi
	opperator=""
	read -p "Enter an opperator" opperator
	case $opperator in
		':q')
			break
			;;
		'*')
			;;
		/)
			;;
		+)
			;;
		-)
			;;
		*)
			echo Error
			continue
			;;
		esac
	result=$(($result $opperator $num))
	echo The result so far is $result
done
echo 'Thanks for using my calculator'