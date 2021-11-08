#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

function make_sequence (string, start) {
    if (start == string) {
        return start
    }
    if (1 == index (string, start)) {
        tail = substr (string, length (start) + 1)
        result = make_sequence(tail, start + 1)
        if (result == "") {
            result = make_sequence(tail, start - 1)
        }
        if (result == "") {
            return ""
        }
        return start "," result
    }
    return ""
}

{
    for (i = 1; i <= length ($1); i ++) {
        result = make_sequence($1, substr ($1, 1, i))
        if (result != "") {
            print result
            next
        }
    }
}
