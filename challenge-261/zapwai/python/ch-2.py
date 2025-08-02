def double_me(ints,start):
    flag = True
    while flag:
        flag = False
        for i in ints:
            if i == start:
                flag = True
                start *= 2
    return start

ints = [5, 3, 6, 1, 12]
start = 3;
print("Input:", ints, "start:", start)
print("Output:", double_me(ints, start))
