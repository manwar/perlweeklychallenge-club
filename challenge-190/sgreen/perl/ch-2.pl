#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'mesh';

sub main($s) {

    # Loop through the alphabet
    my %letter_map = mesh [1 .. 26], ['A' ..'Z'];
 
    # Record completed solutions
    my @solutions = ();

    # Start with the input string
    my @stack = ([$s, '']);

    while (my $item = shift(@stack)) {
        my ($numbers, $letters) = @$item;

        if ($numbers eq '') {
            # If we have no numbers for this stack, it is a solution
            push @solutions, $letters;
        }
        else {
            # Consider either the first single or two numbers
            foreach my $l (1, 2) {
                if (length($numbers) >= $l and exists $letter_map{substr($numbers, 0, $l)}) {
                    # If we have a mapping, add to the stack list with the
                    #  remaining numbers, and appending this letter to the
                    #  letters
                    push @stack, [
                        substr($numbers, $l), $letters.$letter_map{substr($numbers, 0, $l)}];
                }
            }
        }
    }

    # Print the solutions
    if (@solutions) {
        say join ', ', sort(@solutions);
    }
    else {
        say 'No solution possible';
    }
}

main(@ARGV);