raku -e 'say join ", ", grep { .is-prime and .comb.sum.is-prime }, 2..100;'
