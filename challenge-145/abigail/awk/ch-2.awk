#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

function is_palindrome (string, l) {
    l = length (string)
    return l <= 1                                         ? 1  \
         : substr (string, 1, 1) != substr (string, l, 1) ? 0  \
         : is_palindrome(substr (string, 2, l - 2))
}

{
    delete palindromes
    count = 0
    for (i = 1; i <= length ($0); i ++) {
        for (j = i; j <= length ($0); j ++) {
            s = substr ($0, i, j - i + 1)
            if (is_palindrome(s)) {
                if (palindromes [s] ++ == 0) {
                    if (count ++) {
                        printf (" ")
                    }
                    printf ("%s", s)
                }
            }
        }
    }
    printf ("\n")
}
