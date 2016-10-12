#!/bin/bash
result=0
num=""
firstrun=1
while [[ true ]]; do
	invaildNum=0
	read -p "Enter a number: " num
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
				invaildNum=1
				break
				;;
		esac
	done

	if [ $invaildNum -eq 1 ]; then
		invaildNum=0
		continue
	fi

	if [ $firstrun -eq 1 ]; then
		result=$num
		firstrun=0
	else
		result=$(($result $opperator $num))
		echo The result so far is $result
	fi

	opperator=""
	invaildOpp=1
	while [[ $invaildOpp -eq 1 ]]; do
		read -p "Enter an operator: " opperator
		case $opperator in
			':q')
				echo 'Thanks for using my calculator'
				exit
				;;
			'*')
				invaildOpp=0
				;;
			/)
				invaildOpp=0
				;;
			+)
				invaildOpp=0
				;;
			-)
				invaildOpp=0
				;;
			*)
				echo Error
				continue
				;;
			esac
	done
done
echo 'Thanks for using my calculator'