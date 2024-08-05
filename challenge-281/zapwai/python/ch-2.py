def proc(start, end):
    print("Input:", start, "to", end)
    mylist = [moves(start)]
    roundy = -1
    found = 0
    while found == 0:
        roundy += 1
        for old_move in mylist[roundy]:
            if old_move == end:
                found = 1
        if found == 1:
            break
        else:
            L = []
            for old_move in mylist[roundy]:
                for new_move in moves(old_move):
                    L.append(new_move)
            mylist.append(L)
    roundy += 1
    print("Output:", roundy)

def moves(coord):
    l = coord[0]
    row = int(coord[1])
    cols = "abcdefgh"
    col = 1 + cols.index(l)
    r = []
    c = []
    for i in [-2, 2]:
        for j in [-1, 1]:
            c.append(col + i)
            r.append(row + j)
    for i in [-1, 1]:
        for j in [-2, 2]:
            c.append(col + i)
            r.append(row + j)
    mylist = []
    for i in range(7):
        if c[i] < 1 or c[i] > 8:
            continue
        if r[i] < 1 or r[i] > 8:
            continue
        move = str(cols[c[i] - 1]) + str(r[i])
        mylist.append(move)
    return mylist

start = "g2"
end = "a8"
proc(start, end)

start = "g2"
end = "h2"
proc(start, end)
