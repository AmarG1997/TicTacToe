#!/bin/bash -x

echo "Welcome To The TicTacToe"

NO_OF_ROW_COLUMN=3

BOARD_SIZE=$(($NO_OF_ROW_COLUMN*$NO_OF_ROW_COLUMN))

declare -a TicTacToeBoard

function resetBoard()
{
	for (( places=0; places<$BOARD_SIZE; places++ ))
	do
		TicTacToeBoard[$places]="-"
	done
}
resetBoard

echo ${TicTacToeBoard[@]}
