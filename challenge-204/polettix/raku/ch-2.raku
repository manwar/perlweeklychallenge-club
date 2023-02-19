#!/usr/bin/env raku
use v6;
sub MAIN {
   my $reshaped = reshape-matrix([ [ 1 .. 3], [ 4 .. 6] ], 3, 2);
   put $reshaped ?? $reshaped.gist !! 0;
}

sub reshape-matrix ($matrix, $r, $c) {
   my $needed = $r * $c;
   my $available = $matrix.elems;
   $available *= $matrix[0].elems if $available;
   return Nil if $needed != $available;

   # https://stackoverflow.com/questions/41648119/how-can-i-completely-flatten-a-list-of-lists-of-lists/41649110#41649110
   return [$matrix[*;*].rotor($c)];
}
