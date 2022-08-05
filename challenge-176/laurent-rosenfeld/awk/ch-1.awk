function check_multiples(n) {
    split(n, ordered, "")
    asort(ordered)
    len = length(ordered)
    for (j = 2; j <= 6; j++) {
        split(n * j, test, "")
        asort(test)
        if (length(test) != len) {
           return 0
        }
        for (k = 1; k <= len; k++) {
            if (ordered[k] != test[k]) {
                return 0
            }
        }
    }
    return 1
}

BEGIN  {
    i = 1
    while (1) {
        if (check_multiples(i)) {
            print i
            break
        }
    i++
    }
}
