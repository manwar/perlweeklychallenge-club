def proc(ints):
    print( "Input:", ints)
    count = []
    for i in ints:
        bina = bin(i)
        dig = list(bina)
        cnt = 0
        for d in dig:
            if d == '1':
                cnt += 1
        count.append(cnt)
    ords = ints.copy()
    c = 1
    while c != 0:
        c = 0
        for i in range(len(ords) - 1):
            if count[i] > count[i+1]:
                c += 1
                tmp_cnt = count[i]
                tmp_int = ords[i]
                count[i] = count[i+1]
                count[i+1] = tmp_cnt
                ords[i] = ords[i+1]
                ords[i+1] = tmp_int
    c = 1
    while c != 0:
        c = 0
        for i in range(len(ords) - 1):
            if count[i] != count[i+1]:
                continue
            if ords[i] > ords[i+1]:
                c += 1
                tmp_int = ords[i]
                ords[i] = ords[i+1]
                ords[i+1] = tmp_int
                tmp_cnt = count[i]
                count[i] = count[i+1]
                count[i+1] = tmp_cnt
    print("Output:", ords)

ints = [0, 1, 2, 3, 4, 5, 6, 7, 8]
proc(ints)
ints = [1024, 512, 256, 128, 64]
proc(ints)
