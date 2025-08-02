def freq(my_string):
    f = {}
    for k in list('abcdefghijklmnopqrstuvwxyz'):
        f[k] = 0
    for s in list(my_string):
        if s.isalpha():
            f[s.lower()] += 1
    return f

def hash_contains(g, f):
    cnt = 0
    for k in f.keys():
        if f[k] <= g[k]:
            cnt += 1
    if cnt == len(f.keys()):
        return True
    else:
        return False

def proc(my_string, strlist):
    print("Input: string:", my_string)
    print("\t ", strlist)
    ans = []
    for s in strlist:
        if hash_contains(freq(s), freq(my_string)):
            ans.append(s)
    mini = len(ans[0])
    answer = ""
    if mini > 0:
        answer = ans[0]
    for i in range(len(ans)):
        if len(ans[i]) < mini:
            mini = len(ans[i])
            answer = ans[i]
    print("Output:", answer)

my_string = 'aBc 11c'
strlist = ['accbbb', 'abc', 'abbc']
proc(my_string, strlist)

my_string = 'La1 abc'
strlist = ['abcl', 'baacl', 'abaalc']
proc(my_string, strlist)

my_string = 'JB 007'
strlist = ['jj', 'bb', 'bjb']
proc(my_string, strlist)
