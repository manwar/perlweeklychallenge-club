#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Algorithm::Combinatorics 'permutations';
use List::Util 'sum';

sub largest_number (@numbers) {
    # Calculate the largest number using the all supplied numbers
    my $largest = 0;
    my $iter    = permutations( \@numbers );
    while ( my $i = $iter->next ) {
        my $n = join( '', @$i );
        if ( $n > $largest ) {
            $largest = $n;
        }
    }

    return $largest;
}

sub main (@ints) {
    my $largest = -1;
    foreach my $bitwise ( 1 .. 2**scalar(@ints) - 1 ) {
        my @numbers =
          ( map { $ints[$_] } grep { $bitwise & ( 2**$_ ) } ( 0 .. $#ints ) );
        if ( sum(@numbers) % 3 != 0 ) {
            # There is no possible solution with this set of numbers
            next;
        }

        my $this_largest = largest_number(@numbers);
        if ( $this_largest > $largest ) {
            $largest = $this_largest;
        }
    }

    say $largest;
}

main(@ARGV);