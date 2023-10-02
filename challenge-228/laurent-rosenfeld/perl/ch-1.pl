use strict;
use warnings;
use feature 'say';

sub unique_sum {
    my %histo;      # histogram
    $histo{$_}++ for @_;
    my @unique = grep { $histo{$_} == 1 } keys %histo;
    my $sum = 0;
    $sum += $_ for @unique;
    return $sum;
}

for my $test ([2, 1, 3, 2], [1, 1, 1, 1], [2, 1, 3, 4]) {
    printf "%-10s => ", "@$test";
    say unique_sum @$test;
}
