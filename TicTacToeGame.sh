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
boardSides=( 2 4 6 8 )
count=0
flag=0
temp=0
choice=0
row=0
column=2
diagonal=3
corner=4
center=5
side=6

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
		COMPUTER_LETTER="O"
		echo "Player Letter" $PLAYER_LETTER
		echo "Computer Letter" $COMPUTER_LETTER
		flag=0
   else
		PLAYER_LETTER="0"
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
	temp1=1
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
		choice=2
		possiblePosition
	fi

}

#FOR BLOCKING COLUMN POSITIONS
function columnPositionHint()
{

	for (( hintCell=1; hintCell<=3; hintCell=$(($hintCell+1)) ))
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
		choice=3
		possiblePosition
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
		choice=4
		possiblePosition
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
			choice=5
			possiblePosition
	fi

}

#FOR FINDING CENTER POSSITION
function toFindCenter()
{

	if [[ ${gameBoard[4]} -eq 5 ]]
	then
		echo ${gameBoard[4]}
	else
		choice=6
		possiblePosition
	fi

}

#FOR FINDING ALL POSSIBLE SIDES
function possibleSides()
{
	for (( i=0; i<4; i++ ))
   do
      index=${boardSides[$i]}
      if [[ ${gameBoard[$index]} != $PLAYER_LETTER ]] || [[ ${gameBoard[$index]} != $COMPUTER_LETTER ]]
      then
         temp=1
         echo $index
         break
      fi
   done
   if [[ $temp -eq 0 ]]
   then
			choice=7
			possiblePosition
   fi

}

#FOR FINDING ALL POSSIBLE POSITION
function possiblePosition()
{

	case $choice in
		$row)
			position=$(rowPositionHint)
			;;
		$column)
			position=$(columnPositionHint)
			;;
		$diagonal)
			position=$(diagonalPositionHint)
			;;
		$corner)
			position=$(possibleCorner)
			;;
		$center)
			position=$(toFindCenter)
			;;
		$side)
			position=$(possibleSides)
			;;
			*)
			position=$(( RANDOM%9+1 ))
			;;
	esac
	echo $position

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
			gameBoard[(($computerPosition -1))]=$COMPUTER_LETTER
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
