
## Ref.
## If c = a ^ b, then a = c ^ b or a = b ^ c
## Similarly, b = c ^ a or b = a ^ c

## Example 1
## arrEncoded = [1, 2, 3]
## nInitial = 1

## Example 2
arrEncoded = [6, 2, 7, 3]
nInitial = 4

arrOutput = [nInitial]

for nElem in arrEncoded:
    arrOutput.append(arrOutput[-1] ^ nElem)

print (arrOutput)
