#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-254/#TASK2
#
# Task 2: Reverse Vowels
# ======================
#
# You are given a string, $s.
#
# Write a script to reverse all the vowels (a, e, i, o, u) in the given string.
#
## Example 1
##
## Input: $s = "Raku"
## Output: "Ruka"
#
## Example 2
##
## Input: $s = "Perl"
## Output: "Perl"
#
## Example 3
##
## Input: $s = "Julia"
## Output: "Jaliu"
#
## Example 4
##
## Input: $s = "Uiua"
## Output: "Auiu"
#
############################################################
##
## discussion
##
############################################################
#
# Let's first turn the string into an array of characters. Then
# let's collect the position of all vowels (and whether or not
# they were uppercase). Then we can walk through all vowels and
# write them to their new location in the correct (uppwer/lower)
# case.

use strict;
use warnings;

reverse_vowels("Raku");
reverse_vowels("Perl");
reverse_vowels("Julia");
reverse_vowels("Uiua");

sub reverse_vowels {
   my $s = shift;
   print "Input: \"$s\"\n";
   my @chars = split //, $s;
   my @vowels = ();
   my @indices = ();
   foreach my $i (0..$#chars) {
      if(is_vowel($chars[$i])) {
         push @vowels, [ $i, $chars[$i] ];
         unshift @indices, [ $i, is_upper($chars[$i]) ];
      }
   }
   foreach my $j (0..$#vowels) {
      my ($old_index, $char, $is_upper) = @{ $vowels[$j] };
      my ($new_index, $is_upper) = @{ $indices[$j] };
      my $new_char = $char;
      if($is_upper) {
         $new_char = uc($new_char);
      } else {
         $new_char = lc($new_char);
      }
      $chars[$new_index] = $new_char;
   }
   $s = join("", @chars);
   print "Output: \"$s\"\n";

}

sub is_vowel {
   my $char = shift;
   my $vowels = { "a" => 1, "e" => 1, "i" => 1, "o" => 1, "u" => 1 };
   return $vowels->{lc($char)};
}

sub is_upper {
   my $char = shift;
   return $char eq uc($char);
}
