
## arrInputList = ['ab1234', 'cd5678', 'ef1342']  ## Example 1
arrInputList = ['pq1122', 'rs3334']  ## Example 2

arrOuputList = [('0' + str(nIndx) if nIndx < 10 else str(nIndx)) + arrLoop[2:] for nIndx, arrLoop in enumerate(arrInputList)]

print (arrOuputList)
