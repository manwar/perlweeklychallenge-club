#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

say $_, ' => ', roman_maths($_) for @ARGV;

sub roman_maths ($expression) {
   my ($first, $op, $second) = $expression =~ m{
      \A\s* ([IVXLCDM]+) \s* ([-+/*] | \*\*) \s* ([IVXLCOM]+) \s*\z
   }mxs or return 'nescio';
   $first  = roman2dec_no_validate($first)  // return 'nescio';
   $second = roman2dec_no_validate($second) // return 'nescio';
   my $result = $op eq '+' ? ($first + $second)
      : $op eq '-' ? ($first - $second)
      : $op eq '*' ? ($first * $second)
      : $op eq '/' ? ($first % $second ? -1 : $first / $second)
      : $op eq '**' ? ($first ** $second) : 'nescio';
   return dec2roman($result);
   return 'non potest';
}

sub dec2roman ($dec) {
   return 'nulla' if $dec == 0;
   return 'non potest' if $dec < 0 || $dec >= 4000;
   my $retval = '';
   while ($dec > 0) {
      if ($dec >= 1000) {
         $retval .= 'M' x int($dec / 1000);
         $dec %= 1000;
      }
      elsif ($dec >= 900) {
         $retval .= 'CM';
         $dec -= 900;
      }
      elsif ($dec >= 500) {
         $retval .= 'D';
         $dec -= 500;
      }
      elsif ($dec >= 400) {
         $retval .= 'CD';
         $dec -= 400;
      }
      elsif ($dec >= 100) {
         $retval .= 'C' x int($dec / 100);
         $dec %= 100;
      }
      elsif ($dec >= 90) {
         $retval .= 'XC';
         $dec -= 90;
      }
      elsif ($dec >= 50) {
         $retval .= 'L';
         $dec -= 50;
      }
      elsif ($dec >= 40) {
         $retval .= 'XL';
         $dec -= 40;
      }
      elsif ($dec >= 10) {
         $retval .= 'X' x int($dec / 10);
         $dec %= 10;
      }
      else {
         state $lookup = [qw< * I II III IV V VI VII VIII IX >];
         $retval .= $lookup->[$dec];
         $dec = 0;
      }
   }
   return $retval;
}

sub roman2dec_no_validate ($string) {
   state $value_for = {
      I => 1,
      V => 5,
      X => 10,
      L => 50,
      C => 100,
      D => 500,
      M => 1000,
   };
   my $accumulator = 0;
   my $following = 0; # good enough initialization
   for my $letter (reverse split m{}mxs, $string) {
      my $this = $value_for->{$letter};
      if ($this >= $following) {
         $accumulator += $this;
      }
      else {
         $accumulator -= $this;
      }
      $following = $this;
   }
   return $accumulator;
}
