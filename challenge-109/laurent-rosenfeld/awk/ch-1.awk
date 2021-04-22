function chowla(num) {
    sum = 0
    for (i = 2; i <= n/2; i++) {
        if (n % i == 0) {
            sum += i;
        }
    }
    return sum;
}

BEGIN {
    for (n = 1; n <= 19; n++) {
        printf("%i, ", chowla(n));
    }
    printf("%i\n", chowla(20));
}
