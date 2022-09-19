function is_reversible(n) {
    len = length(n)
    m = ""
    for (j = len; j != 0; j--) {
        m = m substr(n, j, 1)
    }
    sum = m + n
    len = length(sum)
    for (k = 1; k <= len; k++) {
        if ((substr(sum, k, 1) % 2) == 0) {
            return 0
        }
    }
    return 1
}

BEGIN {
    for (i = 1; i <= 200; i++) {
        if (is_reversible(i)) {
            printf("%d ", i)
        }
    }
}
