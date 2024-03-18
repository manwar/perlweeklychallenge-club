import re
input = """/a/b/c/d
/a/b/cd
/a/b/cc
/a/b/c/d/e"""

def proc(input):
    line = input.split()
    prefix = line[0]
    cnt = 1
    while cnt > 0:
        cnt = 0
        prefix = prefix[0:prefix.rindex("/")]
        for i in range(len(line)):
            if not re.search("^"+prefix+"\/", line[i]):
                cnt += 1
    return prefix

print(proc(input))
