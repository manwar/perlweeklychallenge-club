
## arrRoutes = [["B", "C"], ["D", "B"], ["C", "A"]]  ## Example 1
arrRoutes = [["A", "Z"]]  ## Example 2

arrDest = set([arrLoop[1] for arrLoop in arrRoutes])
arrStart = set([arrLoop[0] for arrLoop in arrRoutes])
arrOutput = [destLoop for destLoop in arrDest if destLoop not in arrStart]

if len(arrOutput) == 1:
    print (arrOutput[0])
else:
    print (arrOutput)
