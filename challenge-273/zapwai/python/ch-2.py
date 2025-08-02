def proc(mystr):
    print("Input: mystr =", mystr)
    ver = False
    for l in list(mystr):
        if l == 'b':
            ver = True
    if ver:
        bflag = False
        for l in list(mystr):
            if (l == 'a' and bflag):
                ver = False
                break
            else:
                if (l == "b"):
                    bflag = True
    if ver:
        print("Output: true")
    else:
        print("Output: false")

mystr = "aabb"
proc(mystr)
mystr = "abab"
proc(mystr)
mystr = "aaa"
proc(mystr)
mystr = "bbb"
proc(mystr)

