BEGIN {
    fusc[0] = 0
    fusc[1] = 1
    printf "%s", "0 1 "
    for (i = 2; i < 50; i ++) {
        fusc[i] = i % 2 ? fusc[(i - 1)/2] + fusc[(i + 1)/2]:
            fusc[i/2]
        printf "%d ", fusc[i]
    }
    printf "%s\n", ""
}
