primeset = {2, 3, 5, 7, 11, 13, 17, 19}
count= 0
for n in range(2, 20):
    bin_n = format(n, 'b')
    num_1 = 0
    for x in bin_n:
        if x == '1':
            num_1 += 1

    if num_1 in primeset:
        count += 1
        print(n, end =" ")
        if count >= 10:
            break
print("")
