#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);

use List::Util qw(max sum);

sub main {
    my @scores = @_;

    # Sanity checks
    die "You must supply one or more integers\n" unless @scores;
    foreach (@scores) {
        die "The vale '$_' is not an integer\n" unless /^-?[0-9]+$/;
    }

    my @lollies = ();
    foreach my $col ( 0 .. $#scores ) {
        # If this score is higher than the previous score, add one to it.
        # Otherwise, start with 1.
        my $left = $col != 0
          && $scores[$col] > $scores[ $col - 1 ] ? $lollies[ $col - 1 ] + 1 : 1;

        # Likewise, calculate the number of successive increases to the
        # right (or 1 if there are none).
        my $right = 1;
        foreach my $col_right ( $col .. $#scores - 1 ) {
            last if $scores[$col_right] <= $scores[ $col_right + 1 ];
            ++$right;
        }

        # The number of lollies, is the greater of the two values.
        push @lollies, max( $left, $right );
    }

    say 'Result is ', sum(@lollies), ' (', join( ', ', @lollies ), ')';
}

main(@ARGV);
