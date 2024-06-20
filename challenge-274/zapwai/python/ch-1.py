def is_vowel(c):
    return c.lower() in 'aeiou'

def proc(sent):
    print("Input: ", sent)
    print("Output: ", end='')
    words = sent.split(" ");
    for i in range(len(words)):
        A = ""
        for j in range(i+1):
            A += "a"
        lets = list(words[i])
        first_let = lets[0]
        reword = ""
        for k in range(1,len(lets)):
            reword += lets[k]
        reword += first_let
        if is_vowel(first_let):
            print(words[i]+"ma"+A+" ", end='')
        else:
            print(reword+"ma"+A+" ", end='')
    print()

sent = "I love Perl"
proc(sent)
sent = "Perl and Raku are friends"
proc(sent)
sent = "The Weekly Challenge"
proc(sent)

