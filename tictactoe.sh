#!/bin/bash -x

echo "Welcome To The TicTacToe"

NO_OF_ROW_COLUMN=3

BOARD_SIZE=$(($NO_OF_ROW_COLUMN*$NO_OF_ROW_COLUMN))

declare -a TicTacToeBoard
player=""
computer=""

function resetBoard()
{
	for (( places=1; places<=$BOARD_SIZE; places++ ))
	do
		TicTacToeBoard[$places]=$places
	done
}

function letterAssigned()
{
	letter=$((RANDOM%2))
	if [ $letter -eq 0 ]
	then
		player="x"
		computer="0"
	else
		computer="x"
		player="0"
	fi
}

function whoPlayFirst()
{
	toss=$((RANDOM%2))
	if [ $toss -eq 0 ]
	then
		echo "Player play first"
	else
		echo "computer play first"
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


function main()
{
resetBoard
letterAssigned
whoPlayFirst
displayBoard
}
main
