use strict;
use warnings;
use feature qw/say/;

sub max_gap  {
    return 0 if scalar @_ < 2;
    my @sorted = sort { $a <=> $b } @_;
    my %gaps;
    for my $i (1..$#sorted) {
        push @{$gaps{$sorted[$i] - $sorted[$i-1]}}, $i;
    }
    my $max_gap = 0;
    for my $k (keys %gaps) {
        $max_gap = $k if $k > $max_gap;
    }
    return scalar @{$gaps{$max_gap}};
}
for my $test ([<2 5 8 1>], [<2 7>], [3,], [<12 2 6 5 15 9>]) {
    printf "%-20s => %d\n", "@$test", max_gap @$test;
}
