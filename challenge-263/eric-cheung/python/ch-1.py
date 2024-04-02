
## Example 1
## arrInt = [1, 5, 3, 2, 4, 2]
## nK = 2

## Example 2
## arrInt = [1, 2, 4, 3, 5]
## nK = 6

## Example 3
arrInt = [5, 3, 2, 4, 2, 1]
nK = 4

arrOutput = [nIndxLoop for nIndxLoop, elemLoop in enumerate(sorted(arrInt)) if elemLoop == nK]

print (arrOutput)
