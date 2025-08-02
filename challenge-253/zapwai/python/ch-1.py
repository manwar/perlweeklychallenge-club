def proc(words, separator):
    list = []
    for word in words:
        for subword in word.split(separator):
            list.append(subword)
    ans = []
    for l in list:
        if len(l) > 0:
            ans.append(l)
    print("Input :", words, "separator =",separator)
    print("Output:", ans)
words = ["one.two.three", "four.five", "six"]
separator = "."
proc(words, separator)
words = ["$perl$$", "$$raku$"]
separator = "$"
proc(words, separator)
