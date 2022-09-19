function is_disarium(num) {
    n = num
    sum = 0
    len = length(n)
    while (n > 0) {
        sum += (n % 10) ^ len
        n = int(n/10)
        len--
    }
    return (sum == num)
}

BEGIN {
    count = 0
    i = 0
    while (count < 19) {
        if (is_disarium(i)) {
            printf("%d\n", i)
            count++
        }
        i++
    }
}
