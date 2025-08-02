use strict;
use warnings;
use feature 'say';

sub special_numbers {
    my @in = @_;
    my $n = scalar @in;
    my $sq_sum = 0;
    for my $i (0..$#in) {
        $sq_sum += $in[$i] ** 2 unless $n % ($i+1);
    }
    return $sq_sum;
}

for my $test ([<1 2 3 4>], [<2 7 1 19 18 3>]) {
    printf "%-15s => ", "@$test";
    say special_numbers @$test;
}
