def proc(s):
    vow = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']
    stash = []
    print("Input:", s)
    for c in s:
        if c in vow:
            stash.append(c)
    print("Output: ", end='')
    for c in s:
        if c in vow:
            print(stash.pop(), end='')
        else:
            print(c, end='')
    print()

s = "Raku"
proc(s)
s = "Perl"
proc(s)
s = "Julia"
proc(s)
s = "Uiua"
proc(s)
