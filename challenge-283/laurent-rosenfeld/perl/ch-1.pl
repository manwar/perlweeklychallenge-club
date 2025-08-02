use strict;
use warnings;
use feature 'say';

sub find_unique_number {
    my %count;
    $count{$_}++ for @_;
    return (grep { $count{$_ } == 1} keys %count)[0];
}

my @tests = ([<3 3 1>], [<3 2 4 2 4>], [1,], [<4 3 1 1 1 4>]);
for my $test (@tests) {
    printf "%-12s => ", "@$test";
    say find_unique_number @$test;
}
