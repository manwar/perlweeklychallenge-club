use strict;
use warnings;
use feature 'say';

sub count_smaller {
    my @in = @_;
    my @result;
    my @sorted = sort {$a <=> $b } @in;
    for my $i (@in) {
        my $count = 0;
        for my $j (@sorted) {
            last if $j >= $i;
            $count++;
        }
        push @result, $count;
    }
    return @result;
}

for my $test ([<8 1 2 2 3>], [<6 5 4 8>], [<2 2 2>]) {
    printf "%-12s => ", "@$test";
    say join " ", count_smaller @$test;
}
