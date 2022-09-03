@a = split /\D/, $_; say join " ", grep { $_ > $a[0]} @a    #perl -nE


# perl -nE '@a = split /\D/, $_; say join " ", grep { $_ > $a[0]} @a'
# [input] 3 1 4 2 3 5
# [output] 4 5
# [input] 4 9 0 6 2 3 8 5
# [output] 9 6 8 5
