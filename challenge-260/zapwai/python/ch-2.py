def seek_word(word, sorts):
    for i in range(len(sorts)):
        if sorts[i] == word:
            return i
    return -1

def L(k, mylist, h):
    if k == 1:
        h[''.join(mylist)] = 1
    else:
        L(k-1, mylist, h)
        for i in range(k-1):
            if k % 2 == 0:
                swap(i, k-1, mylist)
            else:
                swap(0, k-1, mylist)
            L(k-1, mylist, h)
    
def swap(i, j, mylist):
    tmp = mylist[i]
    mylist[i] = mylist[j]
    mylist[j] = tmp

def proc(word):
    perms = {}
    print("Input:", word)
    let = list(word)
    L(len(word), let, perms)
    sorts = sorted(perms.keys())
    print("Output", 1 + seek_word(word, sorts))

proc("CAT")
proc("GOGGLE")
proc("SECRET")
