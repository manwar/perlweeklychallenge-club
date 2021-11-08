#!/usr/bin/env raku
use v6;
sub binary-palindrome (Int:D $N where * > 0 --> Bool) {
   return False if $N %% 2;
   my ($M, $n) = (0, $N);
   ($M, $n) = (($M +< 1) +| ($n +& 1), $n +> 1) while $n > 0;
   return so $M == $N;
}
sub MAIN (*@args is copy) {
   @args = 1 .. 31;
   put $_, ' -> ', binary-palindrome($_) ?? 1 !! 0 for @args;
}
