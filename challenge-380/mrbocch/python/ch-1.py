from collections import Counter

def isVowel(c):
    if len(c) > 1:
        return False

    match c:
        case "a" | "e" | "i" | "o" | "u":
            return True
        case _:
            return False 

def isConsonant(c):
    if len(c) > 1:
        return False

    return not isVowel(c)

def maxFreq(p, xs):
    c = Counter(x for x in xs if p(x))
    if len(c) == 0:
        return 0

    _, f = c.most_common(1)[0]
    return f 

def sumFrequencies(s):
    return maxFreq(isVowel, s) + maxFreq(isConsonant, s)

assert sumFrequencies("banana")   == 5
assert sumFrequencies("teestett") == 7
assert sumFrequencies("aeiouuaa") == 3
assert sumFrequencies("rhythm")   == 2
assert sumFrequencies("x")        == 1
assert sumFrequencies("")         == 0


