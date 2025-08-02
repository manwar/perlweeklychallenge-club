def vaneck(seq):
    if len(seq) == 1:
        seq.append(0)
    else:
        pop = seq[len(seq)-1]
        done_flag = False
        j = len(seq) - 2
        while j >= 0:
            if (not done_flag) and seq[j] == pop:
                done_flag = True
                seq.append(len(seq) - 1 - j)
            j -= 1
        if not done_flag:
            seq.append(0)
seq = [0]
N = 19
for i in range(N):
    vaneck(seq)
print(seq)

