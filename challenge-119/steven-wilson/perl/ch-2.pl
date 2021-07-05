#!/usr/bin/env perl
# TASK #2 > Sequence without 1-on-1
# 1, 2, 3, 12, 13, 21, 22, 23, 31, 32, 33, 121, 122, 123, 131, ...

use strict;
use warnings;
use Test::More;

ok( get_nth_element(5) == 13,    'Input: $N = 5 Output: 13' );
ok( get_nth_element(10) == 32,   'Input: $N = 10 Output: 32' );
ok( get_nth_element(60) == 2223, 'Input: $N = 60 Output: 2223' );
done_testing();

sub get_nth_element {
    my $nth     = shift;
    my $number  = 1;
    my $element = 1;
    while ( $element != $nth ) {
        $number++;
        if ( $number =~ m/^[1-3]+$/ ) {
            if ( !( $number =~ m/11/ ) ) {
                $element++;
            }
        }
    }
    return $number;
}
