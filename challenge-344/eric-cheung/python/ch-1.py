
## Example 1
## arrInt = [1, 2, 3, 4]
## nX = 12

## Example 2
## arrInt = [2, 7, 4]
## nX = 181

## Example 3
## arrInt = [9, 9, 9]
## nX = 1

## Example 4
## arrInt = [1, 0, 0, 0, 0]
## nX = 9999

## Example 5
arrInt = [0]
nX = 1000

nOutput = int("".join([str(nLoop) for nLoop in arrInt])) + nX
arrOutput = [int(strLoop) for strLoop in str(nOutput)]

print (arrOutput)
