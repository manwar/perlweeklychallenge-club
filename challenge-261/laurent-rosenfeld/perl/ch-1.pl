use strict;
use warnings;
use feature 'say';

sub sum {
    my $sum = 0;
    $sum += $_ for @_;
    return $sum;
}

sub element_digit_sum {
    my @in = @_;
    return abs(sum (@in) - sum (map {split //, $_} @in));
}

my @tests = ( [<1 2 3 45>], [<1 12 3>], [<1 2 3 4>],
              [<236 416 336 350>] );
for my $test (@tests) {
    printf "%-20s => ", "@$test";
    say element_digit_sum @$test;
}
