#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use List::Util 'sum';

sub main {
    my @numbers  = ( join( ' ', @_ ) =~ /(-?\d+)/g );
    my $min_sum  = undef;
    my @min_path = ();

    # Turn the numbers into triangle rows
    my @rows  = ();
    my $count = 0;
    push @rows, [ splice( @numbers, 0, ++$count ) ] while scalar(@numbers);

    # The possible solutions are 2 ^ (@rows -1)
    foreach my $i ( 0 .. 2**$#rows - 1 ) {

        # Now we work through each row for this path. If the bit is 1, we
        #  move to the right. If it is 0, we move to the left.
        my @path = ( $rows[0][0] );
        my $x    = 0;
        foreach my $row ( 1 .. $#rows ) {
            $x++ if $i & ( 2**( $row - 1 ) );
            push @path, $rows[$row][$x];
        }

        # If this sum is less than the previous minimum (or the first),
        #  then we will update our figures.
        my $sum = sum(@path);
        if ( not defined $min_sum or $min_sum > $sum ) {
            $min_sum  = $sum;
            @min_path = @path;
        }
    }

    say join( ' + ', @min_path ), " = $min_sum";
}

main(@ARGV);

