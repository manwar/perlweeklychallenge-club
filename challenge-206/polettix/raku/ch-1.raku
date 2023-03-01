#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { put shortest-time(@args) }

sub shortest-time (@times) {
   my \period = 24*60;
   @times
      .map({(.comb(/\d+/)».Int «*» (60, 1)).sum})  # turn everything into minutes
      .combinations(2)                             # create all possible pairs
      .map(->($x, $y) { ($x - $y) % period })      # calculate difference, modulo "period"
      .map({min($^x, period - $^x)})               # consider that and its reciprocal
      .min                                         # take the minimum, as requested
}
