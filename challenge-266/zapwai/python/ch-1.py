def proc(line1, line2):
    words = []
    for l in line1.split(" "):
        words.append(l)
    for l in line2.split(" "):
        words.append(l)
    words.sort()
    match_flag = False
    ans = []
    for i in range(len(words) - 1):
        if match_flag:
            if words[i] != words[i+1]:
                match_flag = False
            continue
        if words[i] == words[i+1]:
            match_flag = True
            continue
        ans.append(words[i])
    if not match_flag:
        ans.append(words[-1])
    print("Input: line1 =", line1, "line2 =",line2)
    print("Output: ",ans)

line1 = 'Mango is sweet'
line2 = 'Mango is sour'
proc(line1, line2)

line1 = 'Mango Mango'
line2 = 'Orange'
proc(line1, line2)

line1 = 'Mango is Mango'
line2 = 'Orange is Orange'
proc(line1, line2)

