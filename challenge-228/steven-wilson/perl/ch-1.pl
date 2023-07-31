#!/usr/bin/env perl

use 5.12.0;
use Test::More;

cmp_ok( sum_unique( ( 2, 1, 3, 2 ) ), '==', 4,  "2 unique elements" );
cmp_ok( sum_unique( ( 1, 1, 1, 1 ) ), '==', 0,  "0 unique elements" );
cmp_ok( sum_unique( ( 2, 1, 3, 4 ) ), '==', 10, "all elements unique" );
done_testing();

sub sum_unique {
    my @elements = @_;
    my %element_count;
    my $sum = 0;
    for (@elements) {
        $element_count{$_}++;
    }
    for ( keys %element_count ) {
        if ( $element_count{$_} == 1 ) {
            $sum += $_;
        }
    }
    return $sum;
}
