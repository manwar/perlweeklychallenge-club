function is_abundant(n) {
    sum = 0
    for (i = 2; i <= n/2; i++) {
        if (n % i == 0) {
            sum += i
            if (sum > n) {
                return 1
            }
        }
    }
    return 0
}

BEGIN {
    n = 1
    count = 0
    while (count < 20) {
        if (is_abundant(n)) {
            printf("%d ", n)
            count++
        }
        n += 2
    }
}
