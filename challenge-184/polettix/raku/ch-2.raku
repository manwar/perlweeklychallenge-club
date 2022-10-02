#!/usr/bin/env raku
use v6;
sub MAIN {
   my @l = '1 2', 'p q r', 's 3', '4 5 t';
   my ($digits, $letters) = split-array(@l);
   say $digits;
   say $letters;
}

sub split-array (@list) {
   my (@digits, @letters);
   for @list -> $item {
      my (@ds, @ls);
      for $item.comb(/\S/) -> $char {
         if ($char ~~ /\d/) { @ds.push: $char }
         else               { @ls.push: $char }
      }
      @digits.push: @ds if @ds;
      @letters.push: @ls if @ls;
   }
   return (@digits, @letters);
}
