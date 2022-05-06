for <1 2 3>, <2 3 4> -> @n {
    say @n, " -> ", ([~&] $_ for @n.combinations(2)).sum;
}
