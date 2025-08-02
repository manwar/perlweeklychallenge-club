def proc(ints):
    cnts = [0]
    while (len(cnts) < len(ints)):
        cnts.append(0)
    for i in range(len(ints)):
        for j in range(len(ints)):
            if (ints[i] > ints[j]):
                cnts[i] += 1
    print("Input: [", end='')
    for i in range(len(ints) - 1):
        print(f"{ints[i]}, ", end='')
    print(f"{ints[len(ints)-1]}]")        
    print("Output: [", end='')
    for i in range(len(cnts) - 1):
        print(f"{cnts[i]}, ", end='')
    print(f"{cnts[len(cnts)-1]}]")
        
ints = [5,2,1,6]
proc(ints)

ints = [1,2,0,3]
proc(ints)

ints = [0,1]
proc(ints)
