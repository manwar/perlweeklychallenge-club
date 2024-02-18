m = [ [ 3,  7,  8],
      [ 9, 11, 13],
      [15, 16, 17],
     ]

print("Input: M = ")
for i in range(len(m)):
    print("\t",m[i])

luck = -1
mins = []
maxs = []
for i in range(len(m)):
    mins.append( min(m[i]) )
for j in range(len(m[0])):
    col = []
    for i in range(len(m)):
        col.append( m[i][j] )
    maxs.append( max(col) )
for val in mins:
    for val2 in maxs:
        if val == val2:
            print(f"Output: {val}")
            break
