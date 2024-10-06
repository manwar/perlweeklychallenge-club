use strict;
use warnings;
use feature 'say';

sub third_max {
    my %unique = map { $_ => 1 } @_;
    my @sorted = sort { $b <=> $a } keys %unique;
    return exists $sorted[2] ? $sorted[2] : $sorted[0];
}

my @tests = ( [5, 6, 4, 1], [4, 5], [1, 2, 2, 3] );
for my $test (@tests) {
    printf "%-10s => ", "@$test";
    say third_max @$test;
}
