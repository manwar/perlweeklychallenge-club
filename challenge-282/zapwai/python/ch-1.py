def proc(my_int):
    print("Input:", my_int)
    numb = -1
    current = 0
    prev = 0
    cnt = 0
    num = []
    t = my_int
    while t != 0:
        num.append(t % 10)
        t = int(t/10);
    num.reverse()
    for i in range(len(num)):
        prev = current
        current = num[i]
        if prev == current:
            cnt += 1
        else:
            if cnt == 2:
                numb = prev
                break
            else:
                cnt = 0
    print("Output:", numb)

my_int = 123444567
proc(my_int)
my_int = 1233334
proc(my_int)
my_int = 10020003
proc(my_int)
