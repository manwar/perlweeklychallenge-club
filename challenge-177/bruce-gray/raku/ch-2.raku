constant @Palindromic_Prime_Cyclops_Numbers =
    grep &is-prime,
    map { $_ ~ '0' ~ .flip if !/0/ },   # Without `!/0/`, we get OEIS A082435 instead of A136098
    ^Inf;

# Could optimize by only generating 1|3|7|9 as initial digit, but this already runs in under 1 second.

say join ', ', @Palindromic_Prime_Cyclops_Numbers.head(20);
