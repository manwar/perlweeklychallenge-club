def comp(f, g):
    for k in g.keys():
        if (k not in f.keys()):
            return 0
        elif (f[k] < g[k]):
            return 0
    return 1


def tally(f, word):
    for c in word:
        f[c] = 0
    for c in word:
        f[c] += 1
    
def proc(allow):
    f = {}
    tally(f, allow)
    fh = open("004-file.txt", "r")
    words = []
    for x in fh:
        y = x.rstrip('\r\n');
        words.append(y)
    ans = []
    for word in words:
        g = {}
        tally(g, word)
        if (comp(f,g)):
            ans.append(word)
    print("Input:", allow)
    print("Output:", ans)

allow = "docgotrark"
proc(allow)
