#!/usr/bin/awk
#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk {-f | -t} < input-file
#
# -f: Translate from base 35 to base 10
# -t: Translate to base 35 from base 10
#

BEGIN {
    #
    # Parse command line
    #
    from_base = 0;
    to_base   = 0;
    for (i = 0; i < ARGC; i ++) {
        if (ARGV [i] == "-f") {
            from_base = 1
        }
        if (ARGV [i] == "-t") {
            to_base = 1
        }
    }
    ARGC = 0  # Prevent AWK to process the parameters.

    #
    # Map base-35 digits to base-10 numbers, and back
    #
    BASE   = 35
    for (i = 0; i < 10; i ++) {
        digits  [i] = i
    }
    for (i = 10; i < BASE; i ++) {
        char = sprintf("%c", 65 + i - 10)
        digits [i] = char
        digits [char] = i
    }
}

#
# This is only executed if the -t option is used
#
to_base {
    #
    # Translate the input number from base 10 to base BASE,
    # using a standard mod and divide approach.
    #
    number = $0
    out = ""
    while (number > 0) {
        digit  = number % BASE
        out    = digits [digit] out
        number = int(number / BASE)
    }
}

#
# This is only executed if the -f option is used
#
from_base {
    #
    # Translate the input number from base BASE to base 10,
    # using a standard multiply and add approach.
    #
    out = 0
    n = split ($0, d, "")
    for (i = 1; i <= n; i ++) {
        out = BASE * out + digits [d [i]]
    }
}

#
# Always executed
#
{
    print out
}
