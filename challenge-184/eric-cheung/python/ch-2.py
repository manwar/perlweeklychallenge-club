
## arrInputList = ['a 1 2 b 0', '3 c 4 d']  ## Example 1
arrInputList = ['1 2', 'p q r', 's 3', '4 5 t']  ## Example 2

arrChar = []
arrInt = []

for arrLoop in arrInputList:
    arrSubChar = []
    arrSubInt = []

    arrSplit = arrLoop.split(' ')
    
    for arrSubLoop in arrSplit:
        if arrSubLoop == '0' or arrSubLoop == '1' or arrSubLoop == '2' or arrSubLoop == '3' or arrSubLoop == '4' or arrSubLoop == '5' or arrSubLoop == '6' or arrSubLoop == '7' or arrSubLoop == '8' or arrSubLoop == '9':
            arrSubInt.append(int(arrSubLoop))
        else:
            arrSubChar.append(arrSubLoop)

    if len(arrSubChar) > 0:
        arrChar.append(arrSubChar)

    if len(arrSubInt) > 0:
        arrInt.append(arrSubInt)

print (arrChar)
print (arrInt)
