#!/bin/bash -x

echo "WECLOME : To TicTacToe Game"

#CONSTANT

PLAYER_LETTER=""
COMPUTER_LETTER=""

declare -a gameBoard

#VARIABLE
gameBoard=(1 2 3 4 5 6 7 8 9)
count=0
flag=0

function printBoard()
{

   echo "               "
   echo "   ${gameBoard[0]} | ${gameBoard[1]} | ${gameBoard[2]}"
   echo "  -------------"
   echo "   ${gameBoard[3]} | ${gameBoard[4]} | ${gameBoard[5]}"
   echo "  -------------"
   echo "   ${gameBoard[6]} | ${gameBoard[7]} | ${gameBoard[8]}"
   echo "               "
   toAssigningRowColumnDiagonalValue

}
function getAssignedSymbol()
{

   if [ $((RANDOM%2)) -eq 1 ]
   then
      PLAYER_LETTER="X"
      COMPUTER_LETTER="O"
      echo "Player Letter" $PLAYER_LETTER
      echo "Computer Letter" $COMPUTER_LETTER
      echo "player 1"
   else
      PLAYER_LETTER="0"
      COMPUTER_LETTER="X"
      echo "Player Letter" $PLAYER_LETTER
      echo "Computer Letter" $COMPUTER_LETTER
      echo "player 2"
   fi
   getUserComputerInput

}

function getUserInput()
{

   echo "User Play"
   echo "Enter the Valid Number beween 0 to 8"
   read number
   for (( i=0; i<9 ;i++ ))
   do
      if [[ ${gameBoard[$i]} -eq $number ]]
      then
         gameBoard[$number -1]=$PLAYER_LETTER
         ((count++))
         flag=1
         printBoard
      fi
   done

}
function getComputerInput()
{

   echo "Computer Play"
   random=$(( RANDOM%8+1 ))
   for (( i=0; i<9; i++ ))
   do
      if [[ ${gameBoard[$i]} -eq $random ]]
      then
         gameBoard[$random -1]=$COMPUTER_LETTER
         ((count++))
         flag=0
         printBoard
         break
      fi
      flag=1
   done

}

function getUserComputerInput()
{

   printBoard
   while [[ $count -lt 9 ]]
   do
      if [[ $flag -eq 0 ]]
      then
         getUserInput
      fi

      if [[ $flag -eq 1 ]]
      then
         getComputerInput
      fi
   done

}

function toCheckMatchOrNot()
{

   if [ ${gameBoard[$1]} == ${gameBoard[$2]} ] && [ ${gameBoard[$2]} == ${gameBoard[$3]} ] 
   then
      if [[ $flag -eq 1 ]]
      then
               echo "User.... Win"
      else
                  echo "Computer.... Win"
      fi
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

   getAssignedSymbol

}

main

