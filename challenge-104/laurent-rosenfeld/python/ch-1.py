fusc = list(range(0, 50))
for i in range (2, 50):
    fusc[i] = fusc[int(i/2)] if i % 2 == 0 else fusc[int((i-1)/2)] + fusc[int((i+1)/2)]
print (fusc)
