# The Weekly Challenge 271
# Task 2 Sort by 1 Bits

use v5.30.0;
use warnings;

sub sbob {
    my @arr = $_[0]->@*;
    @arr = sort {num_of_one_bits($a)<=>num_of_one_bits($b) || $a<=>$b} @arr;
    return [@arr];
}

sub num_of_one_bits {
    my $num = $_[0];
    my $str = unpack("B32", pack("N", $num));
    my $ones = grep {$_==1} split "", $str;
    return $ones;
}

say join ", ", sbob([0, 1, 2, 3, 4, 5, 6, 7, 8])->@*;
say join ", ", sbob([1024, 512, 256, 128, 64])->@*;
