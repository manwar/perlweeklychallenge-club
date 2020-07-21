from sys import argv

n = int(argv[1])
S = [0, 1, 3, 2]

def gray_code(n, S):
    fmt = f"0{n-1}b"
    S2 = [eval(f"0b1{x}") for x in [f"{x:{fmt}}" for x in S][::-1]]
    return S + S2

for i in range(3, n+1):
    S = gray_code(i, S)

print(S)
