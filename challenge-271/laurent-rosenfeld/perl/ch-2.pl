use strict;
use warnings;
use feature 'say';

sub bit_w {
    # bit weight function: returns number of 1s in the
    # binary representation of the input integer
    my $out = 0;
    $out += $_ for split //, sprintf "%b", shift;
    return $out;
}
sub bit_sort {
    sort { bit_w($a) <=> bit_w($b) or $a <=> $b } @_;
}

my @tests = ( [0, 1, 2, 3, 4, 5, 6, 7, 8],
              [1024, 512, 256, 128, 64],
              [7, 23, 512, 256, 128, 64] );
for my $test (@tests) {
    printf "%-20s => ", "@$test";
    say join " ", bit_sort @$test;
}
