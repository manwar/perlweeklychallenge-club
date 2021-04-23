BEGIN {
    max = 10
    tr[0, 0] = 1
    results[0] = 1
    for (row = 1; row < max; row++) {
        res = tr[row -1, row -1]
        tr[row, 0] = res
        results[row] = res
        for (i = 1; i <= row; i++) {
            tr[row, i] = tr[row, i-1] + tr[row - 1, i-1]
        }
    }
    printf("First Bell numbers are: %d ", results[0])
    for (i = 1; i < max; i++) printf ("%d ", results[i])
    printf("\n");
}
