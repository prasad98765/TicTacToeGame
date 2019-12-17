#!/bin/bash -x

echo "WECLOME : To TicTacToe Game"

	gameBoard=(1 2 3 4 5 6 7 8 9)
	echo "r\c 0   1   2"

	echo "0   ${gameBoard[0]} | ${gameBoard[1]} | ${gameBoard[2]}"
	echo 		"---------------"
	echo "1   ${gameBoard[3]} | ${gameBoard[4]} | ${gameBoard[5]}"
	echo 		"---------------"
	echo "2   ${gameBoard[6]} | ${gameBoard[7]} | ${gameBoard[8]}"



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

