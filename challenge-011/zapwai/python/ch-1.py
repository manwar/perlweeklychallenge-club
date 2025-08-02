def f(c):
    m = (212 - 32) / 100
    return 32 + m*c

for i in range(-100, 212):    
    if i == f(i):
        print(f(i))
