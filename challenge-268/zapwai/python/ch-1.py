def check(x, y):
    cnt = 0
    for i in range(len(x)):
        if x[i] == y[i]:
            cnt += 1
    return ( cnt == len(x) )

def proc(x, y):
    print("Input:  x =", x, "\n\ty =", y)
    print("Output: ", end='')
    x.sort();
    y.sort();
    for i in range(-99, 99):
        n = x.copy()
        for j in range(len(n)):
            n[j] += i
        if (check(n, y)):
            print(i)
            break

x = [3, 7, 5]
y = [9, 5, 7]
proc(x, y)

