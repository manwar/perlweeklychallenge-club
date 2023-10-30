use strict;
use warnings;
use feature 'say';

sub to_single_digit {
    my $prod = shift;
    my $count = 0;
    while ($prod > 9) {
        my $temp = 1;
        $temp *= $_ for split //, $prod;
        $prod = $temp;
        $count++;
    }
    return $count;
}

sub my_sort {
    # Schwartzian Tranform
    return map { $_->[0] }
        sort { $a->[1] <=>  $b->[1] || $a->[0] <=> $b->[0] }
        map { [$_, to_single_digit $_] } @_;
}

my @tests = ([<15 99 1 34>], [<50 25 33 22>]);
for my $test (@tests) {
    printf "%-15s => ", "@$test";
    say join ", ", my_sort @$test;
}
