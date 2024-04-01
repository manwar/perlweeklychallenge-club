
## arrMatrix = [[1, 0, 0, 1], [0, 1, 0, 2], [0, 0, 1, 3]]
## arrMatrix = [[1, 1, 0], [0, 1, 0], [0, 0, 0]]  ## Example 1
## arrMatrix = [[0, 1, -2, 0, 1], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]]  ## Example 2
## arrMatrix = [[1, 0, 0, 4], [0, 1, 0, 7], [0, 0, 1, -1]]  ## Example 3
## arrMatrix = [[0, 1, -2, 0, 1], [0, 0, 0, 0, 0], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0]]  ## Example 4
## arrMatrix = [[0, 1, 0], [1, 0, 0], [0, 0, 0]]  ## Example 5
arrMatrix = [[4, 0, 0, 0], [0, 1, 0, 7], [0, 0, 1, -1]]  ## Example 6

t_arrMatrix = [arrLoop for arrLoop in zip(*arrMatrix)]

## print (t_arrMatrix)

arrLead_1_Pos = [-1 if len([1 for arrColLoop in arrRowLoop if arrColLoop == 1]) == 0 else min([nIndx for nIndx, arrColLoop in enumerate(arrRowLoop) if arrColLoop == 1]) for arrRowLoop in arrMatrix]

## print (arrLead_1_Pos)

arrLead_1_Positive = [nLoop for nLoop in arrLead_1_Pos if nLoop >= 0]
arrLead_1_Pos_Positive = [nIndx for nIndx, nLoop in enumerate(arrLead_1_Pos) if nLoop >= 0]
arrLead_1_Pos_Negative = [nIndx for nIndx, nLoop in enumerate(arrLead_1_Pos) if nLoop < 0]

## print (arrLead_1_Positive)
## print (arrLead_1_Pos_Positive)
## print (arrLead_1_Pos_Negative)

bResult = (sorted(arrLead_1_Positive) == arrLead_1_Positive)
if bResult and len(arrLead_1_Pos_Negative) > 0:
    bResult = (arrLead_1_Pos_Positive[-1] < arrLead_1_Pos_Negative[0])
if bResult:
    for arrLoop in t_arrMatrix[:-1]:
        if sum([0 if rLoop == 0 else 1 for rLoop in arrLoop]) > 1:
            bResult = False
            break

print (1 if bResult else 0)
