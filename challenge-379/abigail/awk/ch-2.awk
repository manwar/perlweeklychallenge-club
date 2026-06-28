#!/opt/homebrew/bin/gawk


{
    base  = $1
    limit = $2
    for (n = 0; n < limit; n ++) {
        size = 0
        for (n_c = n; n_c; n_c = int (n_c / base)) {
            size ++
        }
        sum = 0
        for (n_c = n; n_c; n_c = int (n_c / base)) {
            sum += (n_c % base) ** size
        }
        if (sum == n) {
            printf "%d ", n
        }
    }
    printf "\n"
}
