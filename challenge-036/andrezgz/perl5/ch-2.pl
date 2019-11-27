#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-036/
# Task #2
# Write a program to solve Knapsack Problem.
# There are 5 color coded boxes with varying weights and amounts in GBP.
# Which boxes should be choosen to maximize the amount of money
# while still keeping the overall weight under or equal to 15 kgs?
#
# R: (weight = 1 kg, amount = £1)
# B: (weight = 1 kg, amount = £2)
# G: (weight = 2 kg, amount = £2)
# Y: (weight = 12 kg, amount = £4)
# P: (weight = 4 kg, amount = £10)
# Bonus task
# What if you were allowed to pick only 2 boxes or 3 boxes or 4 boxes?
# Find out which combination of boxes is the most optimal?

use strict;
use warnings;

use constant MAX_WEIGHT => 15;
use constant REPEAT_BOX_LIMIT => 1;

my $boxes_data = {
    R => { w => 1 ,  a => 1  },
    B => { w => 1 ,  a => 2  },
    G => { w => 2 ,  a => 2  },
    Y => { w => 12,  a => 4  },
    P => { w => 4 ,  a => 10 }
};

my $max_boxes = shift || scalar keys %$boxes_data;
my @best;

my $boxes = { map { $_ => 1 } keys %$boxes_data };
sequence($_,$boxes) for keys %$boxes;

# The first combination found that maximizes the amount of money
print 'Optimal combination: ' . (join ',', @best) . $/;
print 'Knapsack weight: '  . weight(@best).' kg' . $/;
print 'Knapsack amount: £' . amount(@best) . $/;

sub sequence {
    my ($box, $boxes, @bag) = @_;

    for (1 .. REPEAT_BOX_LIMIT) {

        last if weight(@bag) + $boxes_data->{$box}->{w} > MAX_WEIGHT;

        push @bag, $box;

        @best = @bag if amount(@bag) > amount(@best);

        return if @bag == $max_boxes || weight(@bag) == MAX_WEIGHT;
    }

    delete $boxes->{$box};

    sequence($_, $boxes, @bag) for keys %$boxes;

    $boxes->{$box} = 1;
    pop @bag;

}

sub amount { return sum_data('a',@_) }

sub weight { return sum_data('w',@_) }

sub sum_data {
    my $attr = shift;
    my $sum = 0;
    $sum += $boxes_data->{$_}->{$attr} for @_;
    return $sum;
}

__END__

./ch-2.pl
Optimal combination: P,R,G,B
Knapsack weight: 8 kg
Knapsack amount: £15

./ch-2.pl 3
Optimal combination: P,B,G
Knapsack weight: 7 kg
Knapsack amount: £14

./ch-2.pl 2
Optimal combination: G,P
Knapsack weight: 6 kg
