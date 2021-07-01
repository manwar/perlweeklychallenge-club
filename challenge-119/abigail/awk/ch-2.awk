#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

function next_num (prev_num, tail) {
    #
    # Find the trailing 3s
    #
    match (prev_num, /3*$/)
    tail = substr (prev_num, RSTART)

    #
    # Replace them with 3s
    #
    gsub (/3/, 1, tail)

    #
    # Put the tail back in, incrementing the number before it.
    # If we matched the full number, add a 1
    #
    if (RLENGTH == length (prev_num)) {
        prev_num = 1 tail
    }
    else {
        prev_num = substr (prev_num, 1, RSTART - 2)      \
                  (substr (prev_num, RSTART - 1, 1) + 1) \
                   tail
    }

    #
    # Replace the trailing 1s with 1212...
    #
    gsub (/11/, "12", prev_num)

    return prev_num
}
                   

{
    n = 0
    for (i = 0; i < $1; i ++) {
        n = next_num(n)
    }
    print (n)
}
