#!/usr/bin/awk

function reverse (num) {
    rev = ""
    len = length(num)
    for (i = len; i > 0; i--) {
        rev = rev substr(num, i, 1);
    }
    return rev
}
function is_lychrel(n) {
    for (i = 1; i <= 5; i++) {
        if (n > 10000000) {
            return "is a Lychrel candidate. Reached the 1e7 limit"
        }
        rev = reverse(n)
        # print n, rev
        if (n == rev) { return 0 }
        n += rev
    }
    return "is a lychrel candidate (made 500 iterations)"
}
/[0-9]+/ { print $0, " -> ", is_lychrel($0) }
