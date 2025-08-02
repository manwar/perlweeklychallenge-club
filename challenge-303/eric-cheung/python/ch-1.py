
from itertools import permutations

## arrInt = [2, 1, 3, 0]  ## Example 1
arrInt = [2, 2, 8, 8, 2]  ## Example 2

arrOutput = []

objPerm = permutations(arrInt, 3)

for setLoop in list(objPerm):
    arrLoop = list(setLoop)

    if arrLoop in arrOutput:
        continue

    if arrLoop[0] == 0:
        continue

    if arrLoop[2] % 2 == 1:
        continue

    arrOutput.append(arrLoop)

print ([int("".join(list(map(str, arrLoop)))) for arrLoop in arrOutput])
