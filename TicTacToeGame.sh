#!/bin/bash -x

echo "WECLOME : To TicTacToe Game"

gameBoard=(. . . . . . . . .)
	echo "r\c 0 1 2"
	echo "0   ${gameBoard[0]} ${gameBoard[1]} ${gameBoard[2]}"
	echo "1   ${gameBoard[3]} ${gameBoard[4]} ${gameBoard[5]}"
	echo "2   ${gameBoard[6]} ${gameBoard[7]} ${gameBoard[8]}"

function getAssignedLetter()
{

	if [ $((RANDOM%2)) -eq 1 ]
	then
			echo "player 1 "
			echo "Player Symbol X"
	else
			echo "player 2 "
			echo "Player Symbol x"
	fi

}

getAssignedLetter

