#!/bin/bash -x

echo "Welcome To The TicTacToe"

NO_OF_ROW_COLUMN=3

BOARD_SIZE=$(($NO_OF_ROW_COLUMN*$NO_OF_ROW_COLUMN))

declare -a TicTacToeBoard
player=""
computer=""

function resetBoard()
{
	for (( places=0; places<$BOARD_SIZE; places++ ))
	do
		TicTacToeBoard[$places]="-"
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
function main()
{
resetBoard
echo ${TicTacToeBoard[@]}
letterAssigned
whoPlayFirst
}
main


