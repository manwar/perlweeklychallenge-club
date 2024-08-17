use strict;
use warnings;
use feature 'say';

sub max_frequency {
    my %frequencies;
    for my $i (@_) {
        $frequencies{$i}++;
    }
    my $max = 0;
    for my $i (values %frequencies) {
        $max = $i if $i > $max;
    }
    my $count = 0;
    for my $i (keys %frequencies) {
        $count += $max if $frequencies{$i} == $max;
    }
    return $count;
}

my @tests = ( [1, 2, 2, 4, 1, 5], [1, 2, 3, 4, 5]);
for my $test (@tests) {
    printf "%-15s => ", "@$test";
    say max_frequency @$test;
}
