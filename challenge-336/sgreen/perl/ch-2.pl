#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'sum';

sub main (@scores) {
    my @score_stack = ();

    foreach my $score (@scores) {
        if ( $score eq "C" ) {
            # Clear the previous score
            if ( $#score_stack == -1 ) {
                die "No scores to remove for 'C' operation\n";
            }
            pop @score_stack;
        }
        elsif ( $score eq "D" ) {
            # Double the previous score
            if ( $#score_stack == -1 ) {
                die "No scores to double for 'D' operation\n";
            }
            push @score_stack, 2 * $score_stack[-1];
        }
        elsif ( $score eq "+" ) {
            # Sum the previous two scores
            if ( scalar(@score_stack) < 2 ) {
                die "Not enough scores to sum for '+' operation\n";
            }
            push @score_stack, $score_stack[-1] + $score_stack[-2];
        }
        elsif ( $score =~ /^-?\d+$/ ) {
            # It's a valid integer score
            push @score_stack, $score;
        }
        else {
            # We don't know what score this is
            die "Invalid score entry: '$score'\n";
        }
    }

    say sum(@score_stack);
}

main(@ARGV);
