# The Weekly Challenge 243
# Task 2 Floor Sum
use v5.30.0;
use warnings;

sub fs {
    my @nums = @_;
    my $sum = 0;
    for my $m (@nums) {
        for my $n (@nums) {
            $sum += int($m/$n);
        }
    }
    return $sum;
}

use Test::More tests=>2;
ok fs(2,5,9) == 10;
ok fs(7,7,7,7,7,7,7) == 49;
