def proc(sentence, keys) :
    print("Input: Sentence =", sentence, "keys = ", keys)
    num = 0
    for word in sentence.split(" "):
        tally = 0
        for key in keys:
            if key in word:
                break
            else:
                tally += 1
        
        if tally == len(keys):
            num += 1

    print("Output:", num)

sentence = "Perl Weekly Challenge"
keys = ['l', 'a']
proc(sentence, keys)
sentence = "Perl and Raku"
keys = ['a']
proc(sentence, keys)
sentence = "Well done Team PWC"
keys = ['l', 'o']
proc(sentence, keys)
