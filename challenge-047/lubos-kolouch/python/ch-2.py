#!python3

count = 0
for i in range(100, 10001):
    if i % int(str(i)[0]+str(i)[2]) == 0:
        print(i)
        count += 1
        if count == 20:
            break
