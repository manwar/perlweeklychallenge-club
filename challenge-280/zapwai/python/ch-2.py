def proc(mystr):
    print("Input:", mystr)
    cnt = 0
    words = mystr.split('|')
    for i in range(len(words)):
        if i % 2 == 0:
            for l in list(words[i]):
                if l == "*":
                    cnt += 1
    print("Output:", cnt)
mystr = "p|*e*rl|w**e|*ekly|"
proc(mystr)
mystr = "perl"
proc(mystr)
mystr = "th|ewe|e**|k|l***ych|alleng|e"
proc(mystr)

