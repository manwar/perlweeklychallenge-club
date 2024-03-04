def proc(ints):
    cnt = 0;
    for i in ints:
        if len(str(i)) % 2 == 0:
            cnt += 1
    print("Input:", ints)
    print("Output:", cnt)

ints = [10, 1, 111, 24, 1000]
ints2 = [111, 1, 11111]
ints3 = [2, 8, 1024, 256]
proc(ints)
proc(ints2)
proc(ints3)
