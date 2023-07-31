#!/usr/bin/env raku
use v6;
sub MAIN (*@expressions) { put($_, ' => ', roman-maths($_)) for @expressions }

sub roman-maths ($expression) {
   my $match = $expression ~~ /
   ^^
      \s* (<[ I V X L C D M]>+)
      \s* (<[ \- \+ \/ \*\* \* ]>+)
      \s* (<[ I V X L C O M]>+)
      \s*
   $$/ or return 'nescio';
   my $first = $match[0].Str;
   my $op = $match[1].Str;
   my $second = $match[2].Str;
   $first  = roman2dec-no-validate($first)  // return 'nescio';
   $second = roman2dec-no-validate($second) // return 'nescio';
   my $result = $op eq '+' ?? ($first + $second)
      !! $op eq '-' ?? ($first - $second)
      !! $op eq '*' ?? ($first * $second)
      !! $op eq '/' ?? ($first % $second ?? -1 !! $first / $second)
      !! $op eq '**' ?? ($first ** $second) !! 'nescio';
   return dec2roman($result);
   return 'non potest';
}

sub dec2roman ($dec is copy) {
   return 'nulla' if $dec == 0;
   return 'non potest' if $dec < 0 || $dec >= 4000;
   my $retval = '';
   while $dec > 0 {
      if $dec >= 1000 {
         $retval ~= 'M' x ($dec div 1000);
         $dec %= 1000;
      }
      elsif $dec >= 900 {
         $retval ~= 'CM';
         $dec -= 900;
      }
      elsif $dec >= 500 {
         $retval ~= 'D';
         $dec -= 500;
      }
      elsif $dec >= 400 {
         $retval ~= 'CD';
         $dec -= 400;
      }
      elsif $dec >= 100 {
         $retval ~= 'C' x ($dec div 100);
         $dec %= 100;
      }
      elsif $dec >= 90 {
         $retval ~= 'XC';
         $dec -= 90;
      }
      elsif $dec >= 50 {
         $retval ~= 'L';
         $dec -= 50;
      }
      elsif $dec >= 40 {
         $retval ~= 'XL';
         $dec -= 40;
      }
      elsif $dec >= 10 {
         $retval ~= 'X' x ($dec div 10);
         $dec %= 10;
      }
      else {
         state @lookup = < * I II III IV V VI VII VIII IX >;
         $retval ~= @lookup[$dec];
         $dec = 0;
      }
   }
   return $retval;
}

sub roman2dec-no-validate ($string) {
   state %value_for =
      I => 1,
      V => 5,
      X => 10,
      L => 50,
      C => 100,
      D => 500,
      M => 1000,
   ;
   my $accumulator = 0;
   my $following = 0; # good enough initialization
   for $string.comb.reverse -> $letter {
      my $this = %value_for{$letter};
      if $this >= $following {
         $accumulator += $this;
      }
      else {
         $accumulator -= $this;
      }
      $following = $this;
   }
   return $accumulator;
}
