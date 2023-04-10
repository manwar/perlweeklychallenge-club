# The Weekly Challenge 211
# Task 1 Toeplitz Matrix
use v5.30.0;
use warnings;

sub tm {
    my $mat = $_[0];
    my $m = scalar $mat->@*;
    my $n = scalar $mat->[0]->@*;
    for (1..$m-1) {
        die "not a rectangular matrix\n" if $n != scalar $mat->[$_]->@*;
    }
    my $kk = $m < $n ? $m : $n;
    my $ans = 1;
    say $kk;
    for my $k (1..$kk-1) {
        $ans = $ans && ($mat->[0][0] == $mat->[$k][$k]);
    }
    return $ans;
}

use Test::More tests=>2;
ok tm([ [4, 3, 2, 1],
        [5, 4, 3, 2],
        [6, 5, 4, 3],
      ]);

ok !tm([ [1, 2, 3],
         [3, 2, 1],
       ]);

