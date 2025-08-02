alph = "0123456789abcdefghijklmnopqrstuvwxy"

def to10(s):
    return int(s, 35)

def to35(s):
    q = s;
    o = ""
    while ( q > 0 ):
        rem = q % 35
        o = alph[rem] + o
        q //= 35
    return o

print("Input: (base-10) 100\nOutput: ", to35(100))
print("Input: (base-35) 2u\nOutput: ", to10("2u"))
