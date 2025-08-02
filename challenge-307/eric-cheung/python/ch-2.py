
## Ref.:
## https://www.geeksforgeeks.org/python-sorted-check-two-strings-anagram-not/

def IsAnagrams (strInput_01, strInput_02):
    return (sorted(strInput_01) == sorted(strInput_02))

## arrWords = ["acca", "dog", "god", "perl", "repl"]  ## Example 1
arrWords = ["abba", "baba", "aabb", "ab", "ab"]  ## Example 2

## arrIndxToDel = []
## for nIndx in range(len(arrWords) - 2, -1, -1):
    ## if IsAnagrams (arrWords[nIndx], arrWords[nIndx + 1]):
        ## arrIndxToDel.append(nIndx)

arrIndxToDel = [nIndx for nIndx in range(len(arrWords) - 2, -1, -1) if IsAnagrams (arrWords[nIndx], arrWords[nIndx + 1])]

## print (arrIndxToDel)

## for nIndx in arrIndxToDel:
    ## del arrWords[nIndx]

## print (len(arrWords))

print (len(arrWords) - len(arrIndxToDel))
