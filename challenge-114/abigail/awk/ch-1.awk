#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

function reverse (word, out, i) {
    for (i = length (word); i > 0; i --) {
        out = out substr (word, i, 1)
    }
    return out
}



/^9+$/ {
    print $1 + 2
    next
}

length ($1) == 1 {
    print $1 + 1
    next
}

{
    part1 = substr ($1, 1,  int (length ($1) / 2))
    part2 = substr ($1, 1 + int (length ($1) / 2),  length ($1) % 2)
    part3 = substr ($1, 1 + int (length ($1) / 2) + length ($1) % 2)

    if (reverse(part1) <= part3) {
        part1 = (part1 part2) + 1
        if (length (part2)) {
            part2 = substr (part1,    length (part1),  1)
            part1 = substr (part1, 1, length (part1) - 1)
        }
    }

    print part1 part2 reverse(part1)
}
