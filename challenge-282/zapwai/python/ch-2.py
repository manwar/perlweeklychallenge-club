def proc(mystr):
    print("Input:", mystr)
    let = list(mystr)
    prev = "0"
    curr = ""
    cnt = -1
    for i in range(-1 + len(mystr)):
        curr = let[i]
        if prev.lower() != curr.lower():
            cnt += 1
        prev = curr
    print("Output:", cnt)

mystr = "pPeERrLl"
proc(mystr)
mystr = "rRr"
proc(mystr)
mystr = "GoO"
proc(mystr)
