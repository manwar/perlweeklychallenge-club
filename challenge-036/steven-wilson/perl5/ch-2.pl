#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-11-25
# Week: 036
# Task #2
# Write a program to solve Knapsack Problem.
# There are 5 color coded boxes with varying weights and amounts in GBP.
# Which boxes should be choosen to maximize the amount of money while
# still keeping the overall weight under or equal to 15 kgs?

# R: (weight = 1 kg, amount = £1)
# B: (weight = 1 kg, amount = £2)
# G: (weight = 2 kg, amount = £2)
# Y: (weight = 12 kg, amount = £4)
# P: (weight = 4 kg, amount = £10)
# Bonus task, what if you were allowed to pick only 2 boxes or 3 boxes
# or 4 boxes? Find out which combination of boxes is the most optimal?

# Output from running this code:
#  % perl ch-2.pl
# With 2 boxes: B (1 kg) P (4 kg) (GBP 12) should be choosen.
# With 3 boxes: B (1 kg) G (2 kg) P (4 kg) (GBP 14) should be choosen.
# With 4 boxes: R (1 kg) B (1 kg) G (2 kg) P (4 kg) (GBP 15) should be choosen.
# With 5 boxes: R (1 kg) B (1 kg) G (2 kg) P (4 kg) (GBP 15) should be choosen.

use strict;
use warnings;
use Data::PowerSet qw/ powerset /;

my $max_weight      = 15;
my @colours         = qw/ R B G Y P /;
my @weights         = qw/ 1 1 2 12 4 /;
my @amount          = qw/ 1 2 2 4 10 /;
my @number_of_boxes = qw/ 2 3 4 5 /;

for my $number_of_boxes (@number_of_boxes) {
    my $max_sets = get_max_sets( $number_of_boxes, $max_weight );
    for my $set (@$max_sets) {
        my $amount = 0;
        print "With $number_of_boxes boxes: ";
        for my $position (@$set) {
            print "$colours[$position] ($weights[$position] kg) ";
            $amount += $amount[$position];
        }
        print "(GBP $amount) should be choosen.\n";
    }
}

sub get_max_sets {
    my $max_boxes  = shift;
    my $max_weight = shift;
    my $powerset   = powerset( { max => $max_boxes }, 0 .. ( @amount - 1 ) );
    my $max_seen_amount = 0;
    my $max_seen_weight = 0;
    my @max_seen_set;
    SET: for my $set (@$powerset) {
        my $weight = 0;
        my $amount = 0;
        for my $position (@$set) {
            $weight += $weights[$position];
            $amount += $amount[$position];
            if ( $weight > $max_weight ) {
                next SET;
            }
        }
        if ( $amount > $max_seen_amount ) {
            $max_seen_amount = $amount;
            $max_seen_weight = $weight;
            @max_seen_set    = ();
            push @max_seen_set, $set;
        }
        elsif ( $amount == $max_seen_amount && $weight < $max_seen_weight ) {
            $max_seen_weight = $weight;
            @max_seen_set    = ();
            push @max_seen_set, $set;
        }
        elsif ( $amount == $max_seen_amount && $weight == $max_seen_weight ) {
            push @max_seen_set, $set;
        }
    }
    return \@max_seen_set;
}
