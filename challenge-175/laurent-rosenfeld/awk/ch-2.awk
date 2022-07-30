function gcd (i, j) {
    while(j != 0) {
        k = j
        j = i % j
        i = k
    }
    return i
}
function is_perfect_totient (num) {
    tot = 0
    for (i = 1; i < num; i++) {
        if (gcd(num, i) == 1) {
            tot += 1
        }
    }
    sum = tot + cache[tot]
    cache[num] = sum
    return num == sum
}
BEGIN {
    j = 1
    count = 0
    while (count < 20) {
        if (is_perfect_totient(j)) {
            printf "%d ", j
            count += 1
        }
        j += 1
    }
    print " "
}
