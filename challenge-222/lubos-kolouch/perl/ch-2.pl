#!/usr/bin/perl
use strict;
use warnings;
use List::Util qw(max);

sub last_member {
    my @ints = @{ $_[0] };

    while ( @ints > 1 ) {
        @ints = sort { $b <=> $a } @ints;
        my $x = shift @ints;
        my $y = shift @ints;

        if ( $x != $y ) {
            unshift @ints, $x - $y;
        }
    }

    return $ints[0] || 0;
}

print last_member( [ 2, 7, 4, 1, 8, 1 ] ), "\n";
print last_member( [1] ),                  "\n";
print last_member( [ 1, 1 ] ),             "\n";
