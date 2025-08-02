for i in range(21):
    flag = 1
    if i % 3 == 0:
        flag = 0
        print("fizz", end='')
    if i % 5 == 0:
        flag = 0
        print("buzz", end='')
    if flag == 1:
        print(i, end='')
    print()
