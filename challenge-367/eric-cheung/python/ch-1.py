
## strInput = "1011"  ## Example 1
## strInput = "100"  ## Example 2
## strInput = "111000"  ## Example 3
## strInput = "0101"  ## Example 4
strInput = "1111"  ## Example 5

arrStrSorted = sorted(strInput, reverse = True)

if arrStrSorted[-1] == "0":
    arrStrSorted.pop(0)
    arrStrSorted.append("1")

strOutput = "".join(arrStrSorted)

print (strOutput)
