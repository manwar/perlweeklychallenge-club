#!/usr/bin/env perl
use strict;
use warnings;
use feature qw'say signatures';
no warnings qw'experimental::signatures';

run() unless caller();

# Write a script to generate all Eban Numbers <= 100.
#
#     An Eban number is a number that has no letter ‘e’ in it when the number is spelled in English (American or British).
#
# Example
#
# 2, 4, 6, 30, 32 are the first 5 Eban numbers.

# one two three four five six seven eight nine ten eleven twelve thirteen
# ten twenty thirty fourty fifty sixty seventy eighty ninety

sub run() {
    say join( ", ", eban_numbers() );
}

sub eban_numbers {
    my @eban = grep { is_eban($_) } 1 .. 100;
	return @eban;

}

# only works for numbers up between 1 and 100
sub is_eban($n) {
    if ( length $n == 1 ) {
        return grep { $n == $_ } qw(0 2 4 6);
    }
    if ( length $n == 2 ) {
        my ( $n1, $n2 ) = split( '', $n );
        return ( grep { $n1 == $_ } qw{3 4 5 6} ) && is_eban($n2);
    }
    return 0;
}
