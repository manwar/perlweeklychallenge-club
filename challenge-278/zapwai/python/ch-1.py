def proc(mystr):
    print("Input:", mystr);
    words = []
    keys = []
    for word in mystr.split(" "):
        key = word[len(word)-1 : len(word)]
        w = word[0:-1]
        words.append(w)
        keys.append(key)
    cnt = 1
    while cnt > 0:
        cnt = 0
        for i in range(len(words) - 1):
            if (keys[i] > keys[i + 1]):
                keynum = keys[i]
                keys[i] = keys[i + 1]
                keys[i + 1] = keynum
                word = words[i]
                words[i] = words[i + 1]
                words[i + 1] = word
                cnt += 1

    print("Output:", words)


mystr = "and2 Raku3 cousins5 Perl1 are4"
proc(mystr)
mystr = "guest6 Python1 most4 the3 popular5 is2 language7"
proc(mystr)
mystr = "Challenge3 The1 Weekly2"
proc(mystr)

