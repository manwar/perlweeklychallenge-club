#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

function substrings (n, m, prefix, max, fc, tail, n_prefix) {
    if (length (n) == 0) {
        #
        # End of recursion
        #
        return prefix > -1   && \
               prefix < max  && \
               prefix % m == 0 ? 1 : 0
    }

    fc       = substr (n, 1, 1)
    tail     = substr (n, 2)
    n_prefix = 10 * (prefix == -1 ? 0 : prefix) + fc

    return substrings(tail, m, n_prefix, max) + \
           substrings(tail, m,   prefix, max)
}

{
    print (substrings($1, $2, -1, $1))
}

