from sys import argv

s = argv[1]
seen = set()
nr = []
out = []

for c in s:
    # have we seen c before?
    if c not in seen:
        # add c to nr
        seen.add(c)
        nr.append(c)
    else:
        # remove c from nr
        nr.remove(c)

    # now the FNR is either the last element of nr, or #
    out.append(nr[-1] if nr else '#')

print(''.join(out))
