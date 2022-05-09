#!/usr/bin/env raku
use v6;

put encrypt('playfair example', 'hide the gold in the tree stump');
put decrypt('perl and raku', 'siderwrdulfipaarkcrw');

sub encrypt ($key, $message) { wheatstone-playfair($key, $message, 1) }
sub decrypt ($key, $message) { wheatstone-playfair($key, $message, 5 - 1) }

sub wheatstone-playfair ($key is copy, $message is copy, $off) {
   for $key, $message { $_ = $_.lc; s:g/j/i/ }

   # we don't need no stinkin' matrix, a bijection in two arrays is OK
   my %flag;
   my @letter-at = ($key.comb(/<[a .. z]>/), 'a' .. 'i', 'k' .. 'z', 'j')
      .flat.grep({ %flag{$_}++ == 0 });

   # in Raku we're not C nostalgic any more
   my %pos-of = (0..25).map({ @letter-at[$_] => $_ });

   # take only letters into consideration, split on everything else
   my @message = $message.comb(/<[ a ..z ]>/);
   my @output;
   while @message {

      # first letter is whatever, second letter might be an X
      my $A = shift @message;
      my $B = @message && @message[0] ne $A ?? @message.shift !! 'x';

      # get positions, $A and $B are spoiled on the way but it's OK
      my ($Ax, $Ay, $Bx, $By) =
         ($A, $B).map({ my $v = %pos-of{$_}; ($v % 5, ($v / 5).Int) }).flat;

      # apply Wheatstone-Playfair mapping
      ($Ax, $Ay, $Bx, $By) =
           $Ax == $Bx ?? ($Ax, ($Ay + $off) % 5, $Bx, ($By + $off) % 5)
        !! $Ay == $By ?? (($Ax + $off) % 5, $Ay, ($Bx + $off) % 5, $By)
        !!               ($Bx, $Ay, $Ax, $By);

      @output.push: @letter-at[$Ax + 5 * $Ay, $Bx + 5 * $By].Slip;
   } ## end while (@message)
   return join '', @output;
}
