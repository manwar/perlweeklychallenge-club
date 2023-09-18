# The Weekly Challenge 234
# Task 2 Unequal Triplets

use v5.30.0;
use warnings;
use List::MoreUtils qw/frequency/;

sub ut {
    my @ints = sort {$a <=> $b} @_;
    my $ans = 0;
    my %freq = frequency @ints;
    my @f = values %freq;
    return 0 if scalar @f <= 2;
    for my $i (0..$#f) {
        for my $j ($i+1..$#f) {
            for my $k ($j+1..$#f) {
                $ans += $f[$i]*$f[$j]*$f[$k];
            }
        }
    }
    return $ans;
}

use Test::More tests => 4;
ok ut(4, 4, 2, 4, 3) == 3;
ok ut(1, 1, 1, 1, 1) == 0;
ok ut(4, 7, 1, 10, 7, 4, 1, 1) == 28;
ok ut(1, 1, 1, 1, 2) == 0;
