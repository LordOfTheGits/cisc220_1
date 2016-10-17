#!/bin/bash
fileName=savedPermissions
i=1
while [[ -e $fileName || -e $fileName$i ]]; do
	if [[ ! -e $fileName$i ]]; then
		fileName+=$i
	else
		i=$(($i+1))
	fi
done

ls -l * | awk '{print $1" " $9}' > $fileName