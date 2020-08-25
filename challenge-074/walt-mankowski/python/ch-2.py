from sys import argv

s = argv[1]
seen = {}
nr = []
out = ''

for c in s:
    # have we seen c before?
    if c not in seen:
        # add c to nr
        seen[c] = True
        nr.append(c)
    else:
        # remove c from nr
        if seen[c]:
            nr.remove(c)
            seen[c] = False

    # now the FNR is either the last element of nr, or #
    out += nr[-1] if nr else '#'

print(out)
