#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

use Memoize;
memoize('first_pass');

my @list = map { int } @ARGV;
@list = ( 2, 5, 10, 60, 200 ) unless scalar @list;

for my $n (@list) {
    say join "\t", '', $n, solve_sequence($n);
}

# here we get an array such that index $n is in the array
# using increasingly aggressive methods, then 
sub solve_sequence( $n ) {
    my $j        = $n * 2;
    my @sequence = get_sequence( 1 .. $j );
    while ( !$sequence[$n] ) {
        $j        = $j * 2;
        @sequence = get_sequence( 1 .. $j );
    }
    return $sequence[$n];
}

# the next things we want to do are to remove the blocked numbers
# which contain either 0 or 11, and then add another entry to the
# start of the array so that 1 aligns with 1.
sub get_sequence( @arr ) {
    my @seq =
        grep { !/11/ }
        grep { !/0/ }
        map  { first_pass($_) } @arr;
    unshift @seq, '';
    return @seq;
}

# the numbers will contain only the digits 1, 2 and 3, so to limit 
# the amount of numbers we have to come up with, I first make everything
# base 4. This function is memoizable and so I memoized it.
sub first_pass ( $n ) {
    return $n if $n == 0;
    my @output;
    while ($n) {
        my $i = $n % 4;
        $n = int $n / 4;
        push @output, $i;
    }
    return join '', reverse @output;
}
