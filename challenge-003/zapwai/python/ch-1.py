N = 1000
smooth = []
for i in range(50):
    for j in range(32):
        for k in range(22):
            x = pow(2,i) * pow(3,j) * pow(5,k)
            if x < N:
                smooth.append(x)
smooth.sort()
print(smooth)
