fn = "/usr/share/dict/words"
ourlist = []             # words file but the words letters are rearranged
with open(fn,"r") as file:
    lines = file.readlines()
file.close()
for i in range(len(lines)):
    lines[i] = lines[i].lower().rstrip("\n")
for line in lines:
    ourlist.append(''.join(sorted(line))) # letters in alphabetical order
thelist = sorted(ourlist)
maxlen = 0
maxword = ""
flag = 0
cnt = 0
for i in range(len(thelist) - 1):
    if len(thelist[i]) < 4:
        continue
    if flag == 1:
        if thelist[i+1] != thelist[i]:
            flag = 0
            cnt += 1
            if maxlen < cnt:
                maxlen = cnt
                maxword = thelist[i]
            cnt = 0
        else:
            cnt += 1
    if thelist[i+1] == thelist[i]:
        if flag == 0:
            flag = 1
            cnt = 1
        
print(maxword, maxlen)
