#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util      qw(any sum uniq);
use List::MoreUtils qw(firstidx);

sub remove_sticks( $sticks, $sticks_to_remove ) {
    foreach my $stick (@$sticks_to_remove) {
        my $pos = firstidx { $stick == $_ } @$sticks;
        if ( $pos == -1 ) {
            die "Couldn't find $stick in " . join( ', ', @$sticks ) . "!\n";
        }

        splice( @$sticks, $pos, 1 );
    }
}

sub make_side( $sticks, $len ) {
    # Go through each unique stick lengths (highest first)
    my @pieces = sort { $b <=> $a } uniq(@$sticks);
    foreach my $piece (@pieces) {
        if ( $piece > $len ) {
            # Too long to use for this side
            next;
        }

        if ( $piece == $len ) {
            # We have found the final stick length for this side
            return [$piece];
        }

        # Try this stick length and call the function again to find another
        #  stick to use
        my @sticks_copy = @$sticks;
        my $pos         = firstidx { $piece == $_ } @sticks_copy;
        splice( @sticks_copy, $pos, 1 );
        my $result = make_side( \@sticks_copy, $len - $piece );
        if ( defined $result ) {
            # We have a solution. Send it upstream
            return [ $piece, @$result ];
        }
    }

    # No combination of sticks make up the required length
    return undef;
}

sub matchstick_square(@sticks) {
    # Make sure we have of a number of sticks that is devisable by four
    if ( sum(@sticks) % 4 ) {
        return 'false';
    }

    my $side_length = sum(@sticks) / 4;

    # No stick can be longer than the length of a side
    if ( any { $_ > $side_length } @sticks ) {
        return 'false';
    }

    while (@sticks) {
        my $side = make_side( \@sticks, $side_length );
        if ( not defined $side ) {
            return 'false';
        }
        remove_sticks( \@sticks, $side );
    }

    return 'true';
}

sub main (@sticks) {
    say matchstick_square(@sticks);
}

main(@ARGV);