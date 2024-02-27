
## arrInt = [10, 1, 111, 24, 1000]  ## Example 1
## arrInt = [111, 1, 11111]  ## Example 2
arrInt = [2, 8, 1024, 256]  ## Example 3

arrOutput = [elemLoop for elemLoop in arrInt if len(str(elemLoop)) % 2 == 0]
print (len(arrOutput))
