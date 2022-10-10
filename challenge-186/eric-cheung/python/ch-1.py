

def GetMergeList(arrList_01, arrList_02):

    arrOutputList = []

    for Loop_a, Loop_b in zip(arrList_01, arrList_02):

        arrOutputList.append(Loop_a)
        arrOutputList.append(Loop_b)

    return arrOutputList


## arrInputList_a = [1, 2, 3]
## arrInputList_b = ["a", "b", "c"]

arrInputList_a = ["a", "b", "c"]
arrInputList_b = [1, 2, 3]

arrOutput = GetMergeList(arrInputList_a, arrInputList_b)

print (arrOutput)
