use strict;
use warnings;
use feature 'say';

sub longest_subseq {
    my @pairs;
    for my $i (0..$#_) {
        for my $j ($i+1..$#_) {
            push @pairs, [$_[$i], $_[$j]];
        }
    }
    my %gaps;
    $gaps{($_->[1] - $_->[0])}++ for @pairs;
    my $max = 0;
    for my $k (keys %gaps) {
        $max = $gaps{$k} if $gaps{$k} > $max;
    }
    # For n gaps, we have n + 1 values
    return $max + 1;
}

for my $test ( [<9 4 7 2 10>], [<3 6 9 12>], [<20 1 15 3 10 5 8>] ) {
    printf "%-18s => ", "@$test";
    say longest_subseq @$test;
}
