import sys
def a(word):
    A = []
    if len(word) == 1:
        A.append(word)
        return A
    letters = list(word)
    for i in range(len(word)):
        leftover = ""
        for j in range(len(word)):
            if i == j:
                continue
            else:
                leftover += letters[j]
                new_words = a(leftover)
        for w in new_words:
            new_word = letters[i] + w
            A.append(new_word)
    return A
args = sys.argv[1:]
for word in args:
    words = set(a(word.lower()))
    fn = "/usr/share/dict/words"
    with open(fn, "r") as file:
        lines = file.readlines()
    file.close()
    for i in range(len(lines)):
        lines[i] = lines[i].lower().rstrip("\n")
    output = []
    for w in words:
        if w in lines:
            output.append(w)
    for out in output:
        print(out)
