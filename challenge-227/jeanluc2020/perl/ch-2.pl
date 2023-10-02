#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-227/#TASK2
#
# Task 2: Roman Maths
# ===================
#
# Write a script to handle a 2-term arithmetic operation expressed in Roman numeral.
#
# Example
#
# IV + V     => IX
# M - I      => CMXCIX
# X / II     => V
# XI * VI    => LXVI
# VII ** III => CCCXLIII
# V - V      => nulla (they knew about zero but didn't have a symbol)
# V / II     => non potest (they didn't do fractions)
# MMM + M    => non potest (they only went up to 3999)
# V - X      => non potest (they didn't do negative numbers)
#
############################################################
##
## discussion
##
############################################################
#
# We use the Roman module from CPAN to convert from/to Roman
# numbers. The rest is handling the operand and the special
# cases for the results
#
use strict;
use warnings;
use Roman;

roman_maths("IV", "+", "V");
roman_maths("M", "-", "I");
roman_maths("X", "/", "II");
roman_maths("XI", "*", "VI");
roman_maths("VII", "**", "III");
roman_maths("V", "-", "V");
roman_maths("V", "/", "II");
roman_maths("MMM", "+", "M");
roman_maths("V", "-", "X");

sub roman_maths {
   my ($num1, $oper, $num2) = @_;
   print "Input: $num1 $oper $num2\n";
   $num1 = arabic($num1);
   $num2 = arabic($num2);
   my $result;
   eval "\$result = $num1 $oper $num2;";
   die "eval error $@" if $@;
   if($result != int($result)) {
      print "Output: non potest\n";
   } elsif ( $result < 0 ) {
      print "Output: non potest\n";
   } elsif ( $result > 3999 ) {
      print "Output: non potest\n";
   } elsif ( $result == 0) {
      print "Output: nulla\n";
   } else {
      print "Output: " . uc(roman($result)) . "\n";
   }
}
