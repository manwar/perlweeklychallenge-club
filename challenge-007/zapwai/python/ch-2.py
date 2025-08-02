import re

def quit():
    print("Output: ()")

def read_file(filename):
    fh = open(filename, "r")
    words = []
    for x in fh:
        y = x.rstrip('\r\n');
        words.append(y)
    return words

def neighbor(word, word_list):
    for w in word_list:
        if dist(w, word) == 1:
            return w

def dist(word1, word2):
    cnt = 0
    for i in range(len(word1)):
        if word1[i] != word2[i]:
            cnt += 1
    return cnt

def check(m, n, A, B):
    ans = []
    for i in range(m+1):
        for j in range(n+1):
            a = intersection(A[i], B[j])
            if len(a) > 0:
                for ick in a:
                    ans.append(ick)
    return ans

def expand(word, words):
    new = []
    for i in range(len(word)):
        pre = word[0:i]
        post = word[i+1:]
        for w in words:
            pattern = str(pre) + "." + str(post)
            if re.search(pattern, w):
                new.append(w)
                
    anew = [item for item in new if item != word]
    return anew


def intersection(A, B):
    int = []
    for i in range(len(A)):
        for j in range(len(B)):
            if A[i] == B[j]:
                int.append(A[i])
    return int

def proc(input1, input2):
    limit = 4                   # max-length of chain is 2*limit

    print("Input:", input1, input2)
    if len(input1) != len(input2):
        return quit()
    filename = "words"
    dicts = read_file(filename)

    cnt = 0
    for word in dicts:
        if re.search("^"+input2+"$", word) or re.search("^"+input1+"$", word):
            cnt += 1
    if cnt < 2:
        print("One of these inputs is not a word.")
        return quit()
        
    wordlen = len(input1)
    words = []
    for d in dicts:
        if len(d) == wordlen:
            words.append(d)

    A = [[input1]]
    B = [[input2]]

    center = []
    lvl = 0
    while lvl < limit and not center:
        anew = []; bnew = []
        for wa in A[lvl]:
            for w in expand(wa, words):
                anew.append(w)
        for wb in B[lvl]:
            for w in expand(wb, words):
                bnew.append(w)

        uniq_a = []
        uniq_b = []
        for item in anew:
            if item not in uniq_a:
                uniq_a.append(item)
        for item in bnew:
            if item not in uniq_b:
                uniq_b.append(item)

        A.append(uniq_a)
        B.append(uniq_b)
        lvl += 1
        center = check(lvl, lvl, A, B)
    if lvl == limit:
        return quit()
    counter = lvl - 1
    mylist = [center[0]]
    x = neighbor(center[0], A[counter])
    y = neighbor(center[0], B[counter])
    if y is not None:
        while counter > 0:
            mylist = [x] + mylist
            mylist.append(y)
            counter -= 1
            x = neighbor(x, A[counter])
            y = neighbor(y, B[counter])

    if x is not None:
        mylist = [x] + mylist
    if y is not None:
        mylist.append(y)
    print("Output:", mylist)
    
l1 = ["pour", "cold", "peer", "knife", "prince"]
l2 = ["made", "warm", "norm", "dance", "prance"]
for i in range(len(l1)):
    proc(l1[i], l2[i])

