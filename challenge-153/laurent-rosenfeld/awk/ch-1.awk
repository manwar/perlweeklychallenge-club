BEGIN {
    left_fact = 1
    fact = 1
    for (i = 1; i <= 10; i++) {
        printf "%d ", left_fact
        fact *= i
        left_fact += fact
    }
    printf "\n"
}
