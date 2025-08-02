def proc(m):
    print("Input: m = ", m)
    cnt = []
    for i in range(len(m)):
        cnt.append(0)
    pres = 0
    for row in m:
        for entry in row:
            if entry == 1:
                cnt[pres] += 1
        pres += 1
    max = 0
    max_index = 0
    for i in range(len(cnt)):
        if cnt[i] > max :
            max_index = i
            max = cnt[i]
    print( "Output: row", max_index + 1, " ( count is", max, ")")

matrix = [ [0, 1],
	   [1, 0],
	  ]
proc(matrix)
matrix = [ [0, 0, 0],
	   [1, 0, 1],
	  ]
proc(matrix)
matrix = [ [0, 0],
	   [1, 1],
	   [0, 0],
	  ]
proc(matrix)
