#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { .put for missing-permutations(@args) }

sub missing-permutations (@present) {
   my %present = @present.map({$_ => 1});
   permutations(                  # consider all permutations
         @present[0].comb(/./)    # over letters of the first item
      )».join('')                 # merge each back to a string
      .grep({!%present{$_}++});   # and keep only the unseen
}
