#!/usr/bin/env perl
# Week 147 Task 2
# Pentagon Numbers
# Write a sript to find the first pair of Pentagon Numbers
# whose sum and difference are also a Pentagon Number.
# Answer: First pair is 210 and 330

use strict;
use warnings;
use feature qw/ say /;

my @pentagonal_numbers = qw/ 1 /;
my $first_pair_found   = 0;
my $number             = 2;

while ( not $first_pair_found ) {
    my $next_pn = pentagonal_number($number);
    for (@pentagonal_numbers) {
        if (    is_pentagonal_number( $next_pn - $_ )
            and is_pentagonal_number( $next_pn + $_ ) )
        {
            say "First pair is $_ and $next_pn";
            $first_pair_found = 1;
            last;
        }
    }
    push @pentagonal_numbers, $next_pn;
    $number++;
}

sub pentagonal_number {
    my $n = shift;
    return ( ( 3 * ( $n * $n ) ) - $n ) / 2;
}

sub is_pentagonal_number {
    my $x         = shift;
    my $remainder = ( sqrt( 24 * $x + 1 ) + 1 ) % 6;
    $remainder > 0 ? return 0 : return 1;
}
