#!/bin/bash -x

echo "Welcome To The TicTacToe"

NO_OF_ROW_COLUMN=3

BOARD_SIZE=$(($NO_OF_ROW_COLUMN*$NO_OF_ROW_COLUMN))

declare -a TicTacToeBoard

player=""
computer=""
nextPlayer=o
counter=0
cellNo=0

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
	echo -e "--- --- --- --- ---\n  ${TicTacToeBoard[1]}   |   ${TicTacToeBoard[2]}   |   ${TicTacToeBoard[3]}"
	echo -e "--- --- --- --- ---\n  ${TicTacToeBoard[4]}   |   ${TicTacToeBoard[5]}   |   ${TicTacToeBoard[6]}"
	echo -e "--- --- --- --- ---\n  ${TicTacToeBoard[7]}   |   ${TicTacToeBoard[8]}   |   ${TicTacToeBoard[9]}"
	echo ""
	echo ""
}

function getWinner()
{
	rowCheck
	columnCheck
	digCheck=$(diagonalCheck)

	if [[ $row -eq 0 || $column -eq 0 || $digCheck -eq 0 ]]
	then
		echo "Winner is "${TicTacToeBoard[$cellNo]}
		exit;
	fi
}

function selectCell()
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
		displayBoard
		getWinner
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
			cellNo=$i
			break;
		else
			row=1
		fi
	done
}

function columnCheck()
{
	column=0
	for (( i=1; i<4; i++ ))
	do
		if [ ${TicTacToeBoard[$i]} == ${TicTacToeBoard[(($i+3))]} ] && [ ${TicTacToeBoard[$i]} == ${TicTacToeBoard[(($i+6))]} ]
		then
			column=0
			cellNo=$i
			break;
		else
			column=1
		fi
	done
}

function diagonalCheck()
{
	for (( i=1; i<2; i++ ))
	do
		if [ ${TicTacToeBoard[1]} == ${TicTacToeBoard[5]} ] && [ ${TicTacToeBoard[1]} == ${TicTacToeBoard[9]} ] 
		then
			diagonal=0
			cellNo=5
			break;
		else
			diagonal=1
		fi

		if [ ${TicTacToeBoard[3]} == ${TicTacToeBoard[5]} ] && [ ${TicTacToeBoard[3]} == ${TicTacToeBoard[7]} ]
		then
			diagonal=0
			cellNo=3
			break;
		else
			diagonal=1
		fi
	done
	echo $diagonal
}

function checkOpponentBlockByRow()
{
	for (( i=1; i<=7; i+=3 ))
	do
		if [ $winCheck -eq 0 ]
		then
			if [[ ${TicTacToeBoard[$i]} == ${TicTacToeBoard[(($i+1))]} && ${TicTacToeBoard[(($i+2))]} == $(($i+2)) && ${TicTacToeBoard[$i]} == $1 ]]
			then
				TicTacToeBoard[$(($i + 2))]=$computer
				winCheck=1
				displayBoard

			elif [[ ${TicTacToeBoard[(($i+1))]} == ${TicTacToeBoard[(($i+2))]} && ${TicTacToeBoard[$i]} == $i && ${TicTacToeBoard[(($i+1))]} == $1 ]]
			then
				TicTacToeBoard[$i]=$computer
				winCheck=1
				displayBoard

   			elif [[ ${TicTacToeBoard[$i]} == ${TicTacToeBoard[(($i+2))]} && ${TicTacToeBoard[(($i+1))]} == $(($i+1)) && ${TicTacToeBoard[$i]} == $1 ]]
      			then
            			TicTacToeBoard[(($i+1))]=$computer
            			winCheck=1
				displayBoard
			fi
      		fi
   	done
}

function checkOpponentBlockByColumn()
{
	for (( i=1; i<4; i++ ))
	do
		if [ $winCheck -eq 0 ]
		then
			if [[ ${TicTacToeBoard[$i]} == ${TicTacToeBoard[(($i+3))]} && ${TicTacToeBoard[(($i+6))]} == $(($i+6)) && ${TicTacToeBoard[$i]} == $1 ]]
			then
				TicTacToeBoard[$(($i + 6))]=$computer
				winCheck=1
				displayBoard

			elif [[ ${TicTacToeBoard[(($i+3))]} == ${TicTacToeBoard[(($i+6))]} && ${TicTacToeBoard[$i]} == $i && ${TicTacToeBoard[(($i+3))]} == $1 ]]
			then
				TicTacToeBoard[$i]=$computer
				winCheck=1
				displayBoard

			elif [[ ${TicTacToeBoard[$i]} == ${TicTacToeBoard[$(($i+6))]} && ${TicTacToeBoard[(($i+3))]} == $(($i+3)) && ${TicTacToeBoard[$i]} == $1 ]]
			then
				TicTacToeBoard[(($i+3))]=$computer
				winCheck=1
				displayBoard
			fi
		fi
	done
}

function checkOpponentByDiagonal()
{
	if [ $winCheck -eq 0 ]
	then
		if [[ ${TicTacToeBoard[1]} == ${TicTacToeBoard[5]} && ${TicTacToeBoard[9]} == 9 ]]
		then
			TicTacToeBoard[9]=$computer
			winCheck=1
			displayBoard
		fi

		if [[ ${TicTacToeBoard[9]} == ${TicTacToeBoard[1]} && ${TicTacToeBoard[5]} == 5 ]]
		then
			TicTacToeBoard[5]=$computer
			winCheck=1
			displayBoard
		fi

		if [[ ${TicTacToeBoard[5]} == ${TicTacToeBoard[9]} && ${TicTacToeBoard[1]} == 1 ]]
		then
			TicTacToeBoard[1]=$computer
			winCheck=1
			displayBoard
		fi

		if [[ ${TicTacToeBoard[3]} == ${TicTacToeBoard[5]} && ${TicTacToeBoard[7]} == 7 ]]
		then
			TicTacToeBoard[7]=$computer
			winCheck=1
			displayBoard
		fi

		if [[ ${TicTacToeBoard[5]} == ${TicTacToeBoard[7]} && ${TicTacToeBoard[3]} == 3 ]]
		then
			TicTacToeBoard[3]=$computer
			winCheck=1
			displayBoard
		fi

		if [[ ${TicTacToeBoard[3]} == ${TicTacToeBoard[7]} && ${TicTacToeBoard[5]} == 5 ]]
		then
			TicTacToeBoard[5]=$computer
			winCheck=1
			displayBoard
		fi
	fi
}

function checkCorner()
{
	for (( i=1; i<8; i=$(($i+6)) ))
	do
		if [ $winCheck -eq 0 ]
		then
			if [ ${TicTacToeBoard[i]} != $player ] && [ ${TicTacToeBoard[$i]} != $computer ]
			then
				TicTacToeBoard[$i]=$computer
				displayBoard
				winCheck=1
				break;
			elif [ ${TicTacToeBoard[(($i+2))]} != $player ] && [ ${TicTacToeBoard[(($i+2))]} != $computer ]
			then
				TicTacToeBoard[(($i+2))]=$computer
				displayBoard
				winCheck=1
				break;
			fi
		fi
	done
}

function checkCenter()
{
	if [[ $winCheck -eq 0 && ${TicTacToeBoard[5]} == 5 ]]
	then
		TicTacToeBoard[5]=$computer
		winCheck=1
	fi
}

function checkDiamond()
{
	for (( i=2; i<=8; i=$(($i+2)) ))
	do
		if [ $winCheck -eq 0 ]
		then
			if [ ${TicTacToeBoard[$i]} != $player ] && [ ${TicTacToeBoard[$i]} != $computer ]
			then
				TicTacToeBoard[$i]=$computer
				winCheck=1
				displayBoard
			fi
		fi
	done
}

function playerVsComp()
{
	echo "player symbol : "$player
	echo "computer symbol : "$computer

	while [ $counter -le 9 ]
	do
		if [ $nextPlayer -eq 1 ]
		then
			read -p "Enter Cell Number" cell
			counter=$(($counter+1))
			selectCell $player $cell
			nextPlayer=0
		fi

		if [ $nextPlayer -eq 0 ]
		then
			nextPlayer=1
			winCheck=0
			checkOpponentBlockByRow $computer
			checkOpponentBlockByRow $player
			checkOpponentBlockByColumn $computer
			checkOpponentBlockByColumn $player
			checkOpponentByDiagonal
			checkCorner
			checkCenter
			checkDiamond
			getWinner
		fi
	done
}

function draw()
{
	if [ $counter -eq 10 ]
	then
		echo "Match Draw"
	fi
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
	displayBoard
	playerVsComp
	draw
}
main
