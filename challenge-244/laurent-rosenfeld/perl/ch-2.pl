use strict;
use warnings;
use feature 'say';

sub group_hero {
    # Caution: this works only with input arrays of 3 items
    my @in = sort { $a <=> $b } @_;
    my $sum = 0;
    $sum += $_ * $_ * $_ for @in;
    my ($i, $j) = (0, 0);

    for $j (0..$#in) {
        for $i (1..$#in) {  #gap
            next unless defined $in[$j + $i];
            $sum += $in[$j] * $in[$j + $i] * $in[$j + $i];
        }
    }
    $sum += $in[0] * $in[$#in] * $in[$#in];
    return $sum;
}

for my $test ([<2 1 4>]) {
    printf "%-10s => ", "@$test";
    say group_hero @$test;
}
