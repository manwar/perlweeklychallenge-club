use strict;
use warnings;
use feature 'say';

sub distribute_elements {
    my @arr1 = shift;
    my @arr2 = shift;
    for my $item (@_) {
        if ($arr1[-1] > $arr2[-1]) {
            push @arr1, $item;
        } else {
            push @arr2, $item;
        }
    }
    return "@arr1 @arr2";
}
my @tests = ( [<2 1 3 4 5>], [<3 2 4>], [<5 4 3 8>] );
for my $test (@tests) {
    printf "%-10s => ", "@$test";
    say distribute_elements @$test;
}
