
## Example 1
## arrLetters = ["R", "E", "P", "L"]
## arrWeights = [3, 2, 1, 4]

## Example 2
## arrLetters = ["A", "U", "R", "K"]
## arrWeights = [2, 4, 1, 3]

## Example 3
arrLetters = ["O", "H", "Y", "N", "P", "T"]
arrWeights = [5, 4, 2, 6, 1, 3]

arrSort = sorted([[nWeightLoop, charLoop] for charLoop, nWeightLoop in zip(arrLetters, arrWeights)])

strOutput = "".join([charLoop for nWeightLoop, charLoop in arrSort])

print (strOutput)
