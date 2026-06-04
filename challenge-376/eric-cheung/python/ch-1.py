
## Example 1
## strCo_01 = "a7"
## strCo_02 = "f4"

## Example 2
## strCo_01 = "c1"
## strCo_02 = "e8"

## Example 3
## strCo_01 = "b5"
## strCo_02 = "h2"

## Example 4
## strCo_01 = "f3"
## strCo_02 = "h1"

## Example 5
strCo_01 = "a1"
strCo_02 = "g8"

nIndx_X_01 = int(strCo_01[1]) - 1
nIndx_Y_01 = ord(strCo_01[0]) - 97

nIndx_X_02 = int(strCo_02[1]) - 1
nIndx_Y_02 = ord(strCo_02[0]) - 97

arrChessBoard = [["B", "W", "B", "W", "B", "W", "B", "W"], ["W", "B", "W", "B", "W", "B", "W", "B"], ["B", "W", "B", "W", "B", "W", "B", "W"], ["W", "B", "W", "B", "W", "B", "W", "B"], ["B", "W", "B", "W", "B", "W", "B", "W"], ["W", "B", "W", "B", "W", "B", "W", "B"], ["B", "W", "B", "W", "B", "W", "B", "W"], ["W", "B", "W", "B", "W", "B", "W", "B"]]

print (arrChessBoard[nIndx_X_01][nIndx_Y_01] == arrChessBoard[nIndx_X_02][nIndx_Y_02])
