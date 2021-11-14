#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

BEGIN {
    ord_0 = 48
    ord_9 = 57
    ord_A = 65
    ord_Z = 90
    split ("1 3 1 7 3 9 1", w, " ")
    for (i = ord_0; i <= ord_9; i ++) {
        c [sprintf ("%c", i)] = i - ord_0
    }
    for (i = ord_A; i <= ord_Z; i ++) {
        c [sprintf ("%c", i)] = i - ord_A
    }
}


#
# Check for the right characters, and the correct length.
#
/[^0-9BCDFGHJKLMNPQRSTVWXYZ]/ {print 0; next}
length ($0) != 7              {print 0; next}
/[^0-9]$/                     {print 0; next}

#
# Do the check sum
#
{
    check = 0
    for (i = 1; i <= 7; i ++) {
        check += w [i] * c [substr ($0, i, 1)]
    }
    print (check % 10 == 0 ? 1 : 0)
}
    
