
## Remarks
## https://zhenyu0519.github.io/2020/07/12/lc280/

def wiggleSort(arrSubInput):

    bGtr = False
    arrSubOutput = arrSubInput

    for nLoop in range(len(arrSubOutput) - 1):
        if bGtr and arrSubOutput[nLoop] <= arrSubOutput[nLoop + 1] or not bGtr and arrSubOutput[nLoop] >= arrSubOutput[nLoop + 1]:
            arrSubOutput[nLoop], arrSubOutput[nLoop + 1] = arrSubOutput[nLoop + 1], arrSubOutput[nLoop]

        bGtr = not bGtr

    return arrSubOutput


## arrInputList = [1, 5, 1, 1, 6, 4]  ## Example 1
## arrInputList = [1, 3, 2, 2, 3, 1]  ## Example 2
arrInputList = [1, 5, 2, 3, 4, 6]  ## Example

print (wiggleSort(arrInputList))
