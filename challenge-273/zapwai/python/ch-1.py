def proc(mystr, mychar):
    print("Input: mystr =",mystr, "mychar =", mychar);
    cnt = 0
    for l in list(mystr):
        if l == mychar:
            cnt += 1
    i = 100.0 * (cnt / len(mystr));
    I = int(i)
    r = i - I
    if r >= .5:
        I += 1;
    print("Output:", I);

mystr = "perl";  mychar = "e"
proc(mystr, mychar)
mystr = "java"; mychar = "a"
proc(mystr, mychar)
mystr = "python"; mychar = "m"
proc(mystr, mychar)
mystr = "ada"; mychar = "a"
proc(mystr, mychar)
mystr = "ballerina"; mychar = "l"
proc(mystr, mychar)
mystr = "analitik"; mychar = "k"
proc(mystr, mychar)

