use v6;

sub is-disjoint ($s1, $s2) {
    return ($s1 (&) $s2).elems == 0 ?? 1 !! 0;
}
say is-disjoint (1, 2, 5, 3, 4), (4, 6, 7, 8, 9);
say is-disjoint (1, 3, 5, 7, 9), (0, 2, 4, 6, 8);
