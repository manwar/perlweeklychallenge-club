#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-036/
#
#       Write a program to solve Knapsack Problem.
#
# There are 5 color coded boxes with varying weights and amounts in GBP. Which boxes should be choosen to maximize the amount of money while still keeping the overall weight under or equal to 15 kgs?
# R: (weight = 1 kg, amount = £1)
#B: (weight = 1 kg, amount = £2)
#G : (weight = 2 kg, amount = £2)
#Y: (weight = 12 kg, amount = £4)
#P: (weight = 4 kg, amount = £10)
#
#Bonus task, what if you were allowed to pick only 2 boxes or 3 boxes or 4 boxes? Find out which combination of boxes is the most optimal?
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (),
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 11/30/2019 12:30:15 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw/say/;
use Math::Combinatorics;

my $weight_limit = 15;
my %weight = (
    "R" => 1,
    "B" => 1,
    "G" => 2,
    "Y" => 12,
    "P" => 4,);

my %value = (
    "R" => 1,
    "B" => 2,
    "G" => 2,
    "Y" => 4,
    "P" => 10,);

sub calculate_value {
    my $combo = shift;
    my $total_we;
    my $total_va;
        
    for (@$combo) {
        $total_we += $weight{$_};
        $total_va += $value{$_};
    }

    return $total_va if $total_we <= $weight_limit;

    return 0;
}


# --------- MAIN ---------
my @list = qw/R G B Y P/;

for my $count ( 1 .. scalar @list ) {
    my $max_value = 0;
    my $max_boxes;

    my $combinat = Math::Combinatorics->new(
        count => $count,
        data  => [@list],
    );

    while ( my @combo = $combinat->next_combination ) {
        my $boxes = join( ' ', @combo );
        my $val = calculate_value(\@combo);
        if ($val > $max_value) {
            $max_value = $val;
            $max_boxes = $boxes;
        }
    }

    if ($max_value) {
        say "Best combination for $count boxes is $max_boxes with value $max_value";
    } else {
        say "There is no possible combination for $count boxes under or equal value $max_value";
    }
}

