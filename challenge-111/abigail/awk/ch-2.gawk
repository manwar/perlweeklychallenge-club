#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.gawk < input-file
#

BEGIN {
    IGNORECASE = 1
    longest = ""
    #
    # Create a pattern /^a*b*...z*$/
    #
    pat = "^"
    for (i = 97; i <= 122; i ++) {
        pat = pat sprintf ("%c*", i)
    }
    pat = pat "$"
}

#
# Match words with letters in lexical order; keep longest.
#
match ($0, pat) && length ($0) > length (longest) {
    longest = $0
}

END {
    print longest
}
