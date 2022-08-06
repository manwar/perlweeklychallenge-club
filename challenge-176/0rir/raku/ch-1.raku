#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;

=begin comment
Task 1: Permuted Multiples          Submitted by: Mohammad S Anwar
Find the smallest positive integer x such that x, 2x, 3x, 4x, 5x and 6x
are permuted multiples of each other--all have the same digits but in
different order.
Otput 142857
=end comment

my @result = 142857, 1428570, 1429857, 14285700, 14298570, 14299857,
    142857000, 142985700, 142998570, 142999857, 1428570000, 1429857000,
    1429985700, 1429998570, 1429999857, 14285700000, 14298570000,
    14299857000, 14299985700, 14299998570, 14299999857,
    142857000000, 142857142857, 142985700000, 142998570000,
    142999857000, 142999985700, 142999998570, 142999999857;

    # brutish
constant @permuted-multiple = lazy gather for 1, 10, 100…100_000 -> $p {
    my $a = 142_857 × $p;
    my $z = 143_000 × $p;
    for $a..$z -> $x {
        my $std = $x.comb.sort;
        my $mult = 6;
        next if ($mult-- × $x).comb.sort ne $std;
        next if ($mult-- × $x).comb.sort ne $std;
        next if ($mult-- × $x).comb.sort ne $std;
        next if ($mult-- × $x).comb.sort ne $std;
        next if ($mult   × $x).comb.sort ne $std;
        take $x;
    }
}

sub MAIN( ) { say "Output\n@permuted-multiple[0]" }

=finish
for [0..9] {
    say @permuted-multiple[$_];
    $*OUT.flush;
}
