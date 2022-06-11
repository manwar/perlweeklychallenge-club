function populate_fact() {
    fact[0] = 1
    for (n = 1; n <= 9; n++) {
        fact[n] = n * fact[n - 1]
    }
}
function is_factorion(num) {
    sum = 0
    start_num = num
    for (n = 0; n < length(start_num); n++) {
        sum += fact[num % 10]
        num = int(num / 10)
    }
    return sum == start_num
 }
BEGIN {
    populate_fact()
    for (i = 1; i <= 50000; i++) {
        if (is_factorion(i)) {
            print i
        }
    }
}
