#!/bin/bash -x

echo "WECLOME : To TicTacToe Game"

Arr=(. . . . . . . . .)
	echo "r\c 0 1 2"
	echo "0   ${Arr[0]} ${Arr[1]} ${Arr[2]}"
	echo "1   ${Arr[3]} ${Arr[4]} ${Arr[5]}"
	echo "2   ${Arr[6]} ${Arr[7]} ${Arr[8]}"

function getAssignedLetter()
{

	if [ $((RANDOM%2)) -eq 1 ]
	then
			echo "Player 1 Symbol X"
	else
			echo "Player 2 Symbol 0"
	fi

}

getAssignedLetter
