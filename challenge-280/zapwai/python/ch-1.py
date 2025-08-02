def proc(mystr):
    print("Input:", mystr)
    letter = ""
    gotten = []
    for l in list(mystr):
        for g in gotten:
            if l == g:
                letter = l
        if letter != "":
                break
        else:
            gotten.append(l)
    print("Output:", letter)
mystr = "abcddbca"
proc(mystr)
mystr = "abcd"
proc(mystr)
mystr = "abcdabbb"
proc(mystr)
