def truth(ints):
    N = len(ints)
    
    for i in range(2**N):
        d = format(i,'b')
        D = list(d)
        for i in range(N - len(d)):
            D.insert(0, '0')
        current_list = []
        for j in range(len(D)):
            if '1' == D[j]:
                current_list.append(ints[j])
        if 1 >= len(current_list):
            continue
        tally = 0
        for c in current_list:
            tally = tally | c
        x = format(tally,'b')
        last_dig = x[-1:]
        if last_dig == '0':
            print("\t-->",current_list, x)
            return 1
    return 0

def proc(ints):
    print("Input:", ints)
    if truth(ints):
        print( "Output: true" )
    else:
        print( "Output: false" )

ints = [1, 2, 3, 4, 5]
ints2 = [2, 3, 8, 16]
ints3 = [1, 3, 5, 7, 9]
proc(ints)
proc(ints2)
proc(ints3)
