#!/usr/bin/env perl

# Challenge 036
#
# TASK #2
# Write a program to solve Knapsack Problem.
# There are 5 color coded boxes with varying weights and amounts in GBP. Which
# boxes should be choosen to maximize the amount of money while still keeping
# the overall weight under or equal to 15 kgs?
#
# R: (weight = 1 kg, amount = £1)
# B: (weight = 1 kg, amount = £2)
# G: (weight = 2 kg, amount = £2)
# Y: (weight = 12 kg, amount = £4)
# P: (weight = 4 kg, amount = £10)
# Bonus task, what if you were allowed to pick only 2 boxes or 3 boxes or
# 4 boxes? Find out which combination of boxes is the most optimal?

use Modern::Perl;
use Math::Combinatorics;
use List::Util qw( sum );

my $max_weight = 15;

{
    package Box;
    use Object::Tiny qw( color weight amount );
}

# possible boxes
my @boxes = (
    Box->new( color => 'R', weight => 1, amount => 1 ),
    Box->new( color => 'B', weight => 1, amount => 2 ),
    Box->new( color => 'G', weight => 2, amount => 2 ),
    Box->new( color => 'Y', weight => 12, amount => 4 ),
    Box->new( color => 'P', weight => 4, amount => 10 ),
);

# all combinations
my $max_amount = 0;
my @max_combo;
for my $k (1 .. scalar(@boxes)) {
    my $combinat = Math::Combinatorics->new(count => $k, data => \@boxes);
    while (my @combo = $combinat->next_combination) {
        my $total_weight = sum(map {$_->weight} @combo);
        my $total_amount = sum(map {$_->amount} @combo);
        if ($total_weight <= $max_weight) {
            if ($total_amount > $max_amount) {
                $max_amount = $total_amount;
                @max_combo = @combo;
            }
        }
    }
}

say join("", sort map {$_->color} @max_combo);
