#!/bin/bash -x

echo "Welcome To The TicTacToe"

NO_OF_ROW_COLUMN=3

BOARD_SIZE=$(($NO_OF_ROW_COLUMN*$NO_OF_ROW_COLUMN))

declare -a TicTacToeBoard

player=""
computer=""
nextPlayer=o

function resetBoard()
{
	for (( places=1; places<=$BOARD_SIZE; places++ ))
	do
		TicTacToeBoard[$places]=""$places
	done
}

function letterAssigned()
{
	letter=$((RANDOM%2))
	if [ $letter -eq 0 ]
	then
		player="x"
		computer="o"
	else
		computer="x"
		player="o"
	fi
}

function whoPlayFirst()
{
	toss=$((RANDOM%2))
	if [ $toss -eq 0 ]
	then
		echo 0
	else
		echo 1
	fi
}

function displayBoard()
{
	echo "....... ....... ......"
	echo "  "${TicTacToeBoard[1]}"   |   "${TicTacToeBoard[2]}"   |   "${TicTacToeBoard[3]}" "
	echo "....... ....... ......"
	echo "  "${TicTacToeBoard[4]}"   |   "${TicTacToeBoard[5]}"   |   "${TicTacToeBoard[6]}" "
	echo "....... ....... ......"
	echo "  "${TicTacToeBoard[7]}"   |   "${TicTacToeBoard[8]}"   |   "${TicTacToeBoard[9]}" "
	echo "....... ....... ......"
}

function selectSell()
{
	local flag=0
	cell=$2
	playerVal=$1

		if [ ${TicTacToeBoard[$cell]} == "x" ] ||  [ ${TicTacToeBoard[$cell]} == "o" ]
		then
			echo "Select another cell"
			counter=$(($counter-1))
			playerVsComp
		else
			flag=1
		fi

		if [ $flag -eq 1 ]
		then
			TicTacToeBoard[$cell]=$playerVal
			counter=$(($counter+1))
			echo "board display"
			displayBoard
			rowCheck=$(rowCheck)
			colCheck=$(columnCheck)
			digCheck=$(diagonalCheck)
			if [ $rowCheck -eq 0 ]
			then
				echo "Win"
				exit;
			fi

			if [ $colCheck -eq 0 ]
			then
				echo "Win"
				exit;
			fi

			if [ $digCheck -eq 0 ]
			then
				echo "Win"
				exit;
			fi
		else
			selectSell

		fi
}

function rowCheck()
{
		row=0
		for (( i=1; i<=$BOARD_SIZE; i=$((i+3)) ))
		do
			if [ ${TicTacToeBoard[$i]} == ${TicTacToeBoard[(($i+1))]} ] && [ ${TicTacToeBoard[$i+1]} == ${TicTacToeBoard[(($i+2))]} ]
			then
				row=0
				break;
			else
				row=1
			fi
		done
	echo $row
}

function columnCheck()
{
	column=0
	for (( i=1; i<4; i++ ))
	do
		if [ ${TicTacToeBoard[$i]} == ${TicTacToeBoard[(($i+3))]} ] && [ ${TicTacToeBoard[$i]} == ${TicTacToeBoard[(($i+6))]} ]
		then
				column=0
				break;
		else
				column=1
		fi
	done
	echo $column
}

function diagonalCheck()
{
	for (( i=1; i<2; i++ ))
	do
	if [ ${TicTacToeBoard[1]} == ${TicTacToeBoard[5]} ] && [ ${TicTacToeBoard[1]} == ${TicTacToeBoard[9]} ] 
	then
		diagonal=0
		break;
	else
		diagonal=1
	fi

	if [ ${TicTacToeBoard[3]} == ${TicTacToeBoard[5]} ] && [ ${TicTacToeBoard[3]} == ${TicTacToeBoard[7]} ]
	then
			diagonal=0
			break;
	else
			diagonal=1
	fi
	done
	echo $diagonal
}
counter=0

function playerVsComp()
{
	echo "player symbol : "$player
	echo "computer symbol : "$computer

		while [ $counter -le 9 ]
		do

			if [ $nextPlayer -eq 1 ]
			then
			read -p "Enter Cell Number" cell

				selectSell $player $cell
				nextPlayer=0
			fi

			if [ $nextPlayer -eq 0 ]
			then
				compVal=$(($RANDOM%9+1))
				selectSell $computer $compVal
				nextPlayer=1
			fi
	done
}


function main()
{

resetBoard
letterAssigned
toss=$(whoPlayFirst)
  if [ $toss -eq 0 ]
      then
         nextPlayer=1
         echo "Player play first"
      else
         echo "Computer play first"
         nextPlayer=0
      fi

playerVsComp
}
main
