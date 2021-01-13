#!/usr/bin/env python

def word_break(string, words):
    ans = []
    recursive_helper(string, words, [], ans) 
    return ans 

def recursive_helper(string, words, accum, ans):
    if not string:
        ans.append(accum)
        return
    for word in words:
        if string.startswith(word): 
            recursive_helper(string[len(word):], words, accum + [word], ans)


print(word_break("perlweeklychallenge", ["weekly", "challenge", "perl"]))
print(word_break("perlandraku", ["python", "ruby", "haskell"]))

# multiple solutions
print(word_break("perlandraku", ["perl", "perland", "raku", "and"]))
