from sys import argv

n = int(argv[1])
S = [0, 1, 3, 2]

def gray_code(n, S):
    return S + [2**(n-1) + x for x in S][::-1]

for i in range(3, n+1):
    S = gray_code(i, S)

print(S)
