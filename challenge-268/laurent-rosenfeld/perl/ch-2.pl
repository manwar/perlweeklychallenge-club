use strict;
use warnings;
use feature 'say';

sub number_game {
    my @in = sort { $a <=> $b } @_;
    my @result;
    while (@in) {
        my $i = shift @in;
        my $j = shift @in;
        push @result, $j, $i;
    }

    return join " ", @result;
}

my @tests = ([<2 5 3 4>], [<1 1 4 3 6 4 9 6>], [<1 2 2 3>]);
for my $test (@tests) {
    printf "%-16s => ", "@$test";
    say number_game @$test;
}
