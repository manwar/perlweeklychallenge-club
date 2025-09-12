
## Example 1
## arrInput_01 = [4, 5, 7]
## arrInput_02 = [9, 1, 3, 4]

## Example 2
## arrInput_01 = [2, 3, 5, 4]
## arrInput_02 = [3, 2, 5, 5, 8, 7]

## Example 3
## arrInput_01 = [2, 1, 11, 3]
## arrInput_02 = [2, 5, 10, 2]

## Example 4
## arrInput_01 = [1, 2, 3]
## arrInput_02 = [3, 2, 1]

## Example 5
arrInput_01 = [1, 0, 2, 3]
arrInput_02 = [5, 0]

nMaxDiff = max(abs(nElem_01 - nElem_02) for nElem_01 in arrInput_01 for nElem_02 in arrInput_02)

print (nMaxDiff)
