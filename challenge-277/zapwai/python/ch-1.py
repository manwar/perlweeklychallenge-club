def proc(words1, words2):
    print("Input:", words1, ",", words2)
    words1 = words1
    words2 = words2
    cnt = 0
    for word1 in words1:
        if is_multi(word1, words1):
            continue
        for word2 in words2:
            if (is_multi(word2, words2)):
                continue
            if word1 == word2:
                cnt += 1 

    print("Output:", cnt)

def is_multi(word, words):
    cnt = 0
    for w in words:
        if word == w:
            cnt += 1
    if cnt == 1:
        return 0 
    return 1

words1 = ["Perl", "is", "my", "friend"]
words2 = ["Perl", "and", "Raku", "are", "friend"]
proc(words1, words2)
words1 = ["Perl", "and", "Python", "are", "very", "similar"]
words2 = ["Python", "is", "top", "in", "guest", "languages"]
proc(words1, words2)
