def id_mat(n):
    A = []
    for i in range(n):
        A.append([])
        for j in range(n):
            A[i].append(0)
    for i in range(n):
        A[i][i] = 1
    for i in range(n):
        print(A[i])
    
id_mat(3)
