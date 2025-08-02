def arrange(word):
    arr = list(word)
    mysort = sorted(arr)
    return "".join(mysort)

def proc(mystr, char):
    print("Input: mystr =", mystr, "char =", char)
    ind = mystr.find(char)
    if (ind == -1):
        print("Output:", mystr)
    else:
        begin = mystr[0 : ind + 1]
        end = mystr[ind + 1 : len(mystr)]
        print(arrange(begin)+end)

mystr = "challenge"
char = "e"
proc(mystr, char)
mystr = "programming"
char = "a"
proc(mystr, char)
mystr = "champion"
char = "b"
proc(mystr, char)
