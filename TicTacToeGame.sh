#!/bin/bash -x

echo "WECLOME : To TicTacToe Game"

declare -a gameBoard
gameBoard=(1 2 3 4 5 6 7 8 9)
count=0
function toPrintBoard()
{

	echo "  -----------"
   echo "   ${gameBoard[0]} | ${gameBoard[1]} | ${gameBoard[2]}"
   echo "  -----------"
   echo "   ${gameBoard[3]} | ${gameBoard[4]} | ${gameBoard[5]}"
   echo "  -----------"
   echo "   ${gameBoard[6]} | ${gameBoard[7]} | ${gameBoard[8]}"
	echo "  -----------"
   toAssigningRowColumnDiagonalValue
   getPlayerInput

}
function toAssigningPlayerSymbol()
{

   if [ $((RANDOM%2)) -eq 1 ]
   then
         echo "player 1 play First"
         echo "Player Symbol X"
   else
         echo "player 1 play first"
         echo "Player Symbol x"
   fi
   toPrintBoard

}

function getPlayerInput()
{

   while [[ $count -lt 9 ]]
   do
      echo "Enther the Valid Number beween 1 to 8"
      read number
      count=$(( $count + 1 ))
      gameBoard[$number -1]="X"
      toPrintBoard
   done

}

function toCheckMatchOrNot()
{

   if [ ${gameBoard[$1]} == ${gameBoard[$2]} ] && [ ${gameBoard[$2]} == ${gameBoard[$3]} ]; 
   then
      echo "win"
      exit
	fi

}

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

function main()
{

   toAssigningPlayerSymbol

}

main

