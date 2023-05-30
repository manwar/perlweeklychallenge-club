use strict;
use warnings;
use feature 'say';

sub prod {
    my $prod = shift;
    $prod *= $_ for @_;
    return $prod;
}

sub max_prod {
    my @list = sort { abs($b) <=> abs($a) } @_;
    return prod @list[0..2] if 0 < prod @list[0..2];
    # brute force if we get here
    my $max = $_[0];
    for my $i (0..$#list) {
        for my $j ($i+1..$#list) {
            for my $k ($j+1..$#list) {
                my $prod = $list[$i] * $list[$j] * $list[$k];
                $max = $prod if $prod > $max;
            }
        }
    }
    return $max;
}
for my $test ([3, 1, 2], [4, 1, 3, 2], [-1, 0, 1, 3, 1],
    [-8, 2, -9, 0, -4, 3], [-8, 2, 3, 5, 6]) {
    printf "%-15s => ", "@$test";
    say max_prod @$test;
}
