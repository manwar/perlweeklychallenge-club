def proc(ints):
    print( "Input: ints =", ints)
    third = len(ints) / 3
    freq = [];
    for i in range(100):
        freq.append(0)
    for j in ints:
        freq[j] += 1
    ans = []
    for val in range(max(ints) + 1):
        if freq[val] >= third:
            ans.append(val)
    ans.sort(key=int)
    print("Output:", ans[0])

ints = [1,2,3,3,3,3,4,2]
ints2 = [1,1]
ints3 = [1,2,3]
proc(ints)
proc(ints2)
proc(ints3)
