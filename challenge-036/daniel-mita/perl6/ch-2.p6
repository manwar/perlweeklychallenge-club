#!/usr/bin/env perl6
# I was hoping to attempt some other approaches to this challenge,
# but sadly find myself short on time so just brute-forcing it.

# Create 5 boxes with random weights and amounts
my @boxes = <R B G Y P>.map({ $_ => %( :weight((1..10).roll), :amount((1..100).roll) ) });

.say for |@boxes, '';

.Hash.keys.say for @boxes
  # Generate all possible combinations of boxes
  .combinations(1 .. ∞)
  # Grep the ones with valid weights
  .grep(*.map(*.value<weight>).sum ≤ 15)
  # Sort them by total value
  .sort({ $_($^b) <=> $_($^a) given *.map(*.value<amount>).sum });
