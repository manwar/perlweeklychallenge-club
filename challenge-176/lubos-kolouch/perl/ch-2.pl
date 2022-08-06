package main;
use strict;
use warnings;

sub is_reversible_num {
    my $what = shift;

    my $sum = $what + join '', reverse split //, $what;

    for my $i ( split //, $sum ) {
        return 0 if $i % 2 == 0;
    }

    return 1;
}

sub get_numbers {
    my $limit = shift;

    my $i = 1;

    my @result;

    while ( $i < $limit ) {
        $i++;

        push @result, $i if is_reversible_num($i);
    }

    return \@result;
}

use Test::More;
is_deeply(
    get_numbers(100),
    [   10, 12, 14, 16, 18, 21, 23, 25, 27, 30, 32, 34, 36, 41,
        43, 45, 50, 52, 54, 61, 63, 70, 72, 81, 90
    ],
    'Test 100'
);

done_testing;
1;
