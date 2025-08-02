
## arrInt = [2, 4, 1, 0]  ## Example 1
arrInt = [1, 2, 3, 4]  ## Example 2

arrInt = sorted(arrInt)

nLargest = arrInt[-1]

arrTwiceLess = [elemLoop for elemLoop in arrInt[:-1] if nLargest < elemLoop * 2]

print (1 if len(arrTwiceLess) == 0 else -1)
