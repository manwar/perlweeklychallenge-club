def print_mat(m):
    for row in m:
        print(row)
    print()

def zero_mat(m):
    num_rows = len(m)
    num_cols = len(m[0])

    row_flags = [False for _ in range(num_rows)]
    col_flags = [False for _ in range(num_cols)]
    for r in range(num_rows):
        for c in range(num_cols):
            if m[r][c] == 0:
                row_flags[r] = True
                col_flags[c] = True

    for r in range(num_rows):
        for c in range(num_cols):
            if row_flags[r] or col_flags[c]:
                m[r][c] = 0
    
m1 = [[1,0,1],
      [1,1,1],
      [1,1,1]]

m2 = [[1,0,1],
      [1,1,1],
      [1,0,1]]

print_mat(m1)
print_mat(m2)

zero_mat(m1)
zero_mat(m2)

print_mat(m1)
print_mat(m2)
