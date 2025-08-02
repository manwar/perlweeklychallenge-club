use strict;
use warnings;
use feature 'say';

sub product_sign {
    my $result = 1;
    for my $i (@_) {
        $result *= $i <=> 0;
    }
    return $result;
}
my @tests = ( [<-1 -2 -3 -4 3 2 1>],
              [<1 2 0 -2 -1>],
              [<-1 -1 1 -1 2>] );
for my $test (@tests) {
    printf "%-18s => ", "@$test";
    say product_sign @$test;
}
