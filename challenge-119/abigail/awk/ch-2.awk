#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

function next_num (prev_num, tail) {
    match (prev_num, /3*$/)
    tail = substr (prev_num, RSTART)
    gsub (/3/, 1, tail)
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
    if (match (prev_num, /1+$/)) {
        tail = substr (prev_num, RSTART)
        gsub (/11/, "12", tail)
        prev_num = substr (prev_num, 1, RSTART - 1) tail
    }

    return prev_num
}
                   

{
    n = 0
    for (i = 0; i < $1; i ++) {
        n = next_num(n)
    }
    print (n)
}
