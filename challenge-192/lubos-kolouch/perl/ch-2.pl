#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

sub equal_distribution {
    my @list = @_;
    my $sum  = 0;
    $sum += $_ for @list;

    return -1 if $sum % @list != 0;    # Return -1 if not divisible evenly

    my $target = $sum / @list;
    my $moves  = 0;

    # Repeat until the distribution is complete
    while (1) {
        my $done = 1;

        # Distribute the difference to adjacent cells
        for my $i ( 0 .. $#list - 1 ) {
            if ( $list[$i] < $target ) {
                $list[$i]++;
                $list[ $i + 1 ]--;
                $moves++;
                $done = 0;
            }
            elsif ( $list[$i] > $target ) {
                $list[$i]--;
                $list[ $i + 1 ]++;
                $moves++;
                $done = 0;
            }
        }

        # Break if the distribution is complete
        last if $done;
    }

    return $moves;
}

is( equal_distribution( 1, 0, 5 ), 4,  'Example 1' );
is( equal_distribution( 0, 2, 0 ), -1, 'Example 2' );
is( equal_distribution( 0, 3, 0 ), 2,  'Example 3' );

done_testing();
