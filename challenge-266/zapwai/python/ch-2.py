def proc(matrix):
    fail = False
    N = len(matrix[0])
    print("Input: matrix = ")
    for i in range(N):
        print("\t", end='')
        for j in range(N):
            print(matrix[i][j], end='')
            if (i == j) or (i == N - j - 1):
                if matrix[i][j] == 0:
                    fail = True
            else:
                if matrix[i][j] != 0:
                    fail = True
        print()
    output = ""
    if not fail:
        output = "True"
    else:
        output = "False"
    print("Output:", output)

matrix = [ [1, 0, 0, 2],
	   [0, 3, 4, 0],
	   [0, 5, 6, 0],
	   [7, 0, 0, 1],
	  ]
proc(matrix)

matrix = [ [1, 2, 3],
	   [4, 5, 6],
	   [7, 8, 9],
	  ]
proc(matrix)

matrix = [ [1, 0, 2],
	   [0, 3, 0],
	   [4, 0, 5],
	  ]
proc(matrix)

