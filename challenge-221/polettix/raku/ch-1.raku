#!/usr/bin/env raku
use v6;
sub MAIN (*@words is copy) {
   my $chars = @words.shift;
   say good-strings($chars, @words);
}

sub good-strings ($chars, @words) {
   my $cbag = $chars.comb.Bag;
   return @words.grep({ .comb.Bag ⊆ $cbag })».chars.sum;
}
