#!/bin/bash -x

echo "WECLOME : To TicTacToe Game"

#CONSTANT

PLAYER_LETTER=""
COMPUTER_LETTER=""
TOTAL_POSITION=9

#VARIABLE
declare -a gameBoard
gameBoard=( 1 2 3 4 5 6 7 8 9 )
cornerSides=( 1 3 7 9 )
count=0
flag=0
temp=0
stop=50

#TO PRINT TIC TAC TOE BOARD
function printBoard()
{

	echo "   ${gameBoard[0]} | ${gameBoard[1]} | ${gameBoard[2]}"
	echo "  -------------"
	echo "   ${gameBoard[3]} | ${gameBoard[4]} | ${gameBoard[5]}"
	echo "  -------------"
	echo "   ${gameBoard[6]} | ${gameBoard[7]} | ${gameBoard[8]}"
	toAssigningRowColumnDiagonalValue

}

#ASSIGNED SYMBOL AS PER TOSS
function getAssignedSymbol()
{

	if [ $((RANDOM%2)) -eq 1 ]
	then
		PLAYER_LETTER="X"
		COMPUTER_LETTER="Y"
		echo "Player Letter" $PLAYER_LETTER
		echo "Computer Letter" $COMPUTER_LETTER
		flag=0
   else
		PLAYER_LETTER="Y"
		COMPUTER_LETTER="X"
		echo "Player Letter" $PLAYER_LETTER
		echo "Computer Letter" $COMPUTER_LETTER
		flag=1
   fi
	getUserComputerInput

}


#FOR GET USER INPUT
function getUserInput()
{

	echo "User Play"
	echo "Enter the Valid Number beween 0 to 8"
	read number
	for (( i=0; i<=$TOTAL_POSITION; i++ ))
	do
		if [[ ${gameBoard[$i]} -eq $number ]]
		then
			gameBoard[$number -1]=$PLAYER_LETTER
			flag=1
			((count++))
			printBoard
		fi
	done

}

#FOR BLOCKING ROW POSITIONS
function rowPositionHint()
{

	temp=0
	for (( hintCell=0; hintCell<$TOTAL_POSITION; hintCell=$(($hintCell+3)) ))
	do
		if [[ ${gameBoard[$hintCell]} == ${gameBoard[$hintCell+1]} ]]
		then
			temp=1
			echo ${gameBoard[(($hintCell+2))]}
		break
		elif [[ ${gameBoard[$hintCell+1]} == ${gameBoard[$hintCell+2]} ]]
		then
			temp=1
			echo ${gameBoard[(($hintCell))]}
		break
		elif [[ ${gameBoard[$hintCell]} == ${gameBoard[$hintCell+2]} ]]
		then
			temp=1
			echo ${gameBoard[(($hintCell+1))]}
		break
		fi
	done
	if [[ $temp -eq 0 ]]
	then
		echo $stop
	fi

}

#FOR BLOCKING COLUMN POSITIONS
function columnPositionHint()
{

	for (( hintCell=0; hintCell<3; hintCell=$(($hintCell+1)) ))
	do
		if [[ ${gameBoard[$hintCell]} == ${gameBoard[$hintCell+3]} ]]
		then
			temp=1
			echo ${gameBoard[(($hintCell+6))]}
		break
		elif [[ ${gameBoard[$hintCell]} == ${gameBoard[$hintCell+6]} ]]
		then
			temp=1
			echo ${gameBoard[(($hintCell+3))]}
		break
		elif [[ ${gameBoard[$hintCell+3]} == ${gameBoard[$hintCell+6]} ]]
		then
			temp=1
			echo ${gameBoard[(($hintCell))]}
		break
		fi
	done
	if [[ $temp -eq 0 ]]
	then
		echo $stop
	fi

}

#FOR BLOCKING DIAGONAL POSITIONS
function diagonalPositionHint()
{

	if [[ ${gameBoard[0]} == ${gameBoard[4]} ]]
	then
		temp=1
		echo ${gameBoard[8]}
	elif [[ ${gameBoard[0]} == ${gameBoard[8]} ]]
	then
		temp=1
		echo ${gameBoard[4]}
	elif [[ ${gameBoard[4]} == ${gameBoard[8]} ]]
	then
		temp=1
		echo ${gameBoard[0]}
	elif [[ ${gameBoard[2]} == ${gameBoard[4]} ]]
	then
		temp=1
		echo ${gameBoard[6]}
	elif [[ ${gameBoard[2]} == ${gameBoard[6]} ]]
	then
		temp=1
		echo ${gameBoard[4]}
	elif [[ ${gameBoard[4]} == ${gameBoard[6]} ]]
	then
		temp=1
		echo ${gameBoard[2]}
	fi
	if [[ $temp -eq 0 ]]
	then
		echo $stop
	fi

}

#FOR FINDING ALL POSSIBLE CORNERS
function possibleCorner()
{

	for (( i=0; i<4; i++ ))
	do
		index=${cornerSides[$i]}
		if [[ ${gameBoard[$index]} != $PLAYER_LETTER ]] || [[ ${gameBoard[$index]} != $COMPUTER_LETTER ]]
		then
			temp=1
			echo $index
			break
		fi
	done
	if [[ $temp -eq 0 ]]
	then
			echo $stop
	fi

}


#FOR FINDING ALL POSSIBLE POSITION
function possiblePosition()
{

	local row=$(rowPositionHint)
	if [[ $row -eq $stop ]]
	then
   	local column=$(columnPositionHint)
		if [[ $column -eq $stop ]]
		then
			local diagonal=$(diagonalPositionHint)
			if [[ $diagonal -eq $stop ]]
			then
				local corner=$(possibleCorner)
				if [[ $corner -eq $stop ]]
				then
						randomValue=$(( RANDOM%9+1 ))
						echo $randomValue
				else
					echo $corner
				fi
			else
				echo $diagonal
			fi
		else
			echo $column
		fi
	else
		echo $row
	fi

}

#TO GET COMPUTER INPUT 
function getComputerInput()
{

	echo "Computer Play"
	computerPosition=$(possiblePosition)
	echo $computerPosition
	for (( i=0; i<=8; i++ ))
	do
		if [[ ${gameBoard[$i]} -eq $computerPosition ]]
		then
			gameBoard[(($computerPosition - 1))]=$COMPUTER_LETTER
			((count++))
			flag=0
			printBoard
			break
		fi
	flag=1
	done

}

#TO CALL GETUSERINPUT OR GETCOMPUTERINPUT FUNCTION
function getUserComputerInput()
{

	printBoard
	while [[ $count -lt 9 ]]
	do
		if [[ $flag -eq 0 ]]
		then
			getUserInput
		else
			getComputerInput
		fi
	done

}

#TO CHECK WHO IS WIN
function toCheckMatchOrNot()
{

   if [ ${gameBoard[$1]} == ${gameBoard[$2]} ] && [ ${gameBoard[$2]} == ${gameBoard[$3]} ] 
   then
		if [[ $flag -eq 1 ]]
		then
		      	echo "User.... Win"
		else
					echo "Computer..... Win"
		fi
		exit
	fi

}

#TO ASSIGNED ROW COLUMN DIAGONAL VALUE TO CHECK WIN OR NOT
function toAssigningRowColumnDiagonalValue()
{

  	toCheckMatchOrNot 0 1 2
  	toCheckMatchOrNot 3 4 5
  	toCheckMatchOrNot 6 7 8
	toCheckMatchOrNot 0 3 6
  	toCheckMatchOrNot 1 4 7
  	toCheckMatchOrNot 2 5 8
  	toCheckMatchOrNot 0 4 8
  	toCheckMatchOrNot 2 4 6

}

#MAIN METHOD
function main()
{

	getAssignedSymbol

}

main
