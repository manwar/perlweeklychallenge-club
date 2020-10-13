#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);

sub _remove_character {
    my ( $c, $words ) = @_;
    my @array = ();

    for my $i ( 0 .. $#$words ) {
        # We've exhausted all the characters from this word.
        next if $words->[$i] eq '';

        # The first remaining letter in this word is not what we want.
        next if substr( $words->[$i], 0, 1 ) ne $c;

        # Add to the array striping the letter we used for the word.
        push @array,
          [ map { $_ == $i ? substr( $words->[$_], 1 ) : $words->[$_] }
              0 .. $#$words ];
    }
    return @array;
}

sub main {
    my @words  = @_;
    my $target = pop(@words);

    # Sanity check
    die "You must enter at least three strings" unless scalar(@words) >= 2;

    # If the length of the target is not the sum of the other
    #  strings, we can exit early
    return 0 if length($target) != length( join( '', @words ) );

    my @remaining = ( \@words );
    for my $i ( 1 .. length($target) ) {
        # What character we are trying to match
        my $c = substr( $target, $i - 1, 1 );

        # See if any of the current solutions are still valid by
        #  matching the character
        @remaining = map { _remove_character( $c, $_ ) } @remaining;

        # There are no possible solutions
        return 0 if scalar(@remaining) == 0;
    }

    # We've reached the target!
    return 1;
}

say main(@ARGV);
