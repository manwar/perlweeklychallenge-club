
def IsLastCharA(arrToLoad):

    if len(arrToLoad) % 2 == 0:
        return False

    if len(arrToLoad) == 1 and arrToLoad[0] == 0:
        return True

    for nIndx in range(0, len(arrToLoad) - 2, 2):
        if arrToLoad[nIndx:nIndx + 2] != [1, 0] and arrToLoad[nIndx:nIndx + 2] != [1, 1]:
            return False

    if arrToLoad[-1] == 0:
        return True

    return False


arrInput = [1, 0, 0]  ## Example 1
## arrInput = [1, 1, 1, 0]  ## Example 2


if IsLastCharA(arrInput):
    print ("1")
else:
    print ("0")
