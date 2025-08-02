use strict;
use warnings;
use feature 'say';

sub count_smaller {
    my @in = @_;
    my @result;
    for my $i (@in) {
        my $count = 0;
        for my $j (@in) {
            $count++ if $j < $i;
        }
        push @result, $count;
    }
    return @result;
}

my @tests = ([<5 2 1 6>], [<1 2 0 3>], [<0 1>], [<9 4 9 2>]);
for my $test (@tests) {
    printf "%-12s => ", "@$test";
    say join " ", count_smaller @$test;
}
