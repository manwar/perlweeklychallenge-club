#! /opt/local/bin/perl
#
#       knapsack.pl
#
#       PWC 36 - TASK #2
#       Write a program to solve Knapsack Problem.

#       There are 5 color coded boxes with varying weights and amounts in GBP.
#       Which boxes should be choosen to maximize the amount of money while
#       still keeping the overall weight under or equal to 15 kgs?

#           R: (weight = 1 kg,  amount = £1)
#           B: (weight = 1 kg,  amount = £2)
#           G: (weight = 2 kg,  amount = £2)
#           Y: (weight = 12 kg, amount = £4)
#           P: (weight = 4 kg,  amount = £10)

#       Bonus task, what if you were allowed to pick only 2 boxes or 3 boxes or 4 boxes?
#       Find out which combination of boxes is the most optimal?
#
#       method:
#       (1,0) Bounded Knapsack Problem: If we interpret the challenge to
#           select from only the five boxes specified to exist, the problem is
#           to maximize the sum of the amounts over all cases that satisfy the
#           condition that sum weight <= 15 kg. Since each item can either be
#           selected for the knapsack or not, and there are 5 items, there are
#           at maximum 2**5, or 32 combinations available, only a subset of
#           which satisfy the weight condition. If we assign each box a
#           placement of a binary digit, the combinations can be referenced by
#           the binary numbers 0-31, or 00000 (no boxes) through 11111 (all
#           boxes), with each of the items RGBYP assigned one digit.

#           We filter the generated list according to combinations that weigh
#           less than the maximum, and use these as keys to a hash to computed
#           payout amounts. We find the maximum value here and filter that hash
#           for only those elements that reach that valuation. Doing this way
#           will find and output multiple ways to meet the established criteria,
#           should such exist.
#
#           This functionality can be demonstrated by changing the conditions
#           somewhat, for example:

#               our $cfg = { "R" => { 'cost' => 1,  'payout' =>  1 },
#                           "B" => { 'cost' => 1,  'payout' =>  2 },
#                           "G" => { 'cost' => 2,  'payout' =>  2 },
#                           "Y" => { 'cost' => 12, 'payout' =>  4 },
#                           "Q" => { 'cost' => 4,  'payout' => 10 },
#                           "P" => { 'cost' => 4,  'payout' => 10 }    };
#               our $max_total_cost = 7;

#           produces the output:

#               (1,0) bounded max payout:   14
#               (1,0) bounded knapsack set: GBP
#               (1,0) bounded knapsack set: GQB
#
#
#
#       2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
# use diagnostics;
use feature ":5.26";

## ## ## ## ## CONFIG

    ## a hash is chosen for the configuration for clarity.
    ## the keys are the item names, each has a sub-hash of cost and payout
    our $cfg = { "R" => { 'cost' => 1,  'payout' =>  1 },
                "B" => { 'cost' => 1,   'payout' =>  2 },
                "G" => { 'cost' => 2,   'payout' =>  2 },
                "Y" => { 'cost' => 12,  'payout' =>  4 },
                "P" => { 'cost' => 4,   'payout' => 10 }    };

    our $max_total_cost = 15;


## ## ## ## ## MAIN

## remap cfg hash into an array of arrays, as [key, cost, payout]
## this fixes the order of the keys for future access
## this will be the consistant way to refer to the configuration hash for the bounded problem
our @remapped = map { [$_, $cfg->{$_}->{cost}, $cfg->{$_}->{payout}] } keys $cfg->%*;

## a list of binary numbers that correspond to the posible patterns of objects,
## with each object represented by a position in the number, not unlike a bit vector
my $format  = "%0" . (scalar @remapped) . "b";
my @keys    = map { sprintf $format, $_ } ( 0..(2**(scalar @remapped)-1) );

## a hash of validated keys and their corresponding payout values
my %amounts = map { $_ => amount($_) } grep { weight($_) <= $max_total_cost } @keys;

## sort the list of values and take the first item in the list
my $max_amt = +( sort { $b <=> $a } values %amounts )[0];

## a list of patterns that make the highest value payout
my @max_keys = grep { $amounts{$_} == $max_amt } keys %amounts;

## output
say "(1,0) bounded max payout:   ", $max_amt;

for my $pattern ( @max_keys){
    my $output = "";
    my @pattern = split //, $pattern;
    for my $idx (0..(scalar @remapped - 1)){
        $output .= $pattern[$idx] == 1 ? $remapped[$idx]->[0] : "";
    }
    say "(1,0) bounded knapsack set: ", "$output";
}


## ## ## ## ## SUBS

sub weight {
## splits and calculates the associated cost sum for a given binary key,
## according to the remapped configuration
    my @key = split //, shift;
    my @wgt = map { $_->[1] } @remapped;
    my $weight;
    for (0..(scalar @remapped - 1)) {
       $weight += $wgt[$_] * $key[$_];
    }
    return $weight;
}

sub amount {
## splits and calculates the associated payout sum for a given binary key,
## according to the remapped configuration
    my @key = split //, shift;
    my @amt = map { $_->[2] } @remapped;
    my $amount;
    for (0..(scalar @remapped - 1)) {
       $amount += $amt[$_] * $key[$_];
    }
    return $amount;
}
