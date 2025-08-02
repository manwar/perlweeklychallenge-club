def shifty(c, d):
    alph = 'abcdefghijklmnopqrstuvwxyz'
    ind = alph.index(c)
    A = list(alph)
    return A[d + ind]

def proc(stringy):
    print("Input: str =", stringy);
    lets = []
    puts = []
    for i in range(len(stringy)):
        if i % 2 == 0:
            let = stringy[i:i+1]
            lets.append(let)
        else:
            put = shifty(lets[-1], ord(stringy[i:i+1]) - 48)
            puts.append(put)
    print("Output: ", end='')
    for j in range((len(stringy)//2) ):
        print(lets[j], puts[j], end='', sep='') 
    if (len(stringy)) % 2 == 1:
        print(lets[-1], end='')
    print("\n")

stringy = 'a1c1e1'
proc(stringy)
stringy = 'a1b2c3d4'
proc(stringy)
stringy = 'b2b'
proc(stringy)

