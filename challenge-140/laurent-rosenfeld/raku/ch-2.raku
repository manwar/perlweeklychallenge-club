use v6;

sub mult-table (UInt $i, UInt $j, UInt $k) {
    say (sort 1..$i X* 1..$j)[$k - 1]
}
for (2, 3, 4), (3, 3, 6) -> $a, $b, $c {
    mult-table $a, $b, $c;
}
