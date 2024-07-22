def is_vowel(c):
    if c == 'a' or c == 'e' or c == 'i' or c == 'o' or c == 'u':
        return True
    return False

def proc(mystr):
    print("Input: mystr =", mystr)
    cnt = 0
    for c in list(mystr):
        if is_vowel(c):
            cnt += 1
            
    if cnt % 2 == 0:
        print("Output: true")
    else:
        print("Output: false")
    
mystr = "perl"
proc(mystr)
mystr = "book"
proc(mystr)
mystr = "goodmorning"
proc(mystr)

