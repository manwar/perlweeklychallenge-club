#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-200/#TASK2
#
# A seven segment display is an electronic component, usually used to display
# digits. The segments are labeled 'a' through 'g' as shown:
#
#      a
#   -------
# f |     | b
#   |  g  |
#   -------
# e |     | c
#   |  d  |
#   -------
#
# The encoding of each digit can thus be represented compactly as a truth table:
## my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;
# For example, $truth[1] = ‘bc’. The digit 1 would have segments ‘b’ and ‘c’ enabled.
#
# Write a program that accepts any decimal number and draws that number as a
# horizontal sequence of ASCII seven segment displays, similar to the
# following:
#
# -------  -------  -------
#       |  |     |  |     |
#       |  |     |  |     |
# -------                  
# |        |     |  |     |
# |        |     |  |     |
# -------  -------  -------
#
# To qualify as a seven segment display, each segment must be drawn (or not drawn) according to your @truth table.
#
# The number "200" was of course chosen to celebrate our 200th week!


##############################################
##
## discussion
##
##############################################
##
## basically we need to find a way to print one digit after another
## since terminal output is a bit special, we basically need to
## build that number as a series of strings one after another
## then we can append the next digit as a series of strings to the
## existing ones
## at the end we can print everything
##
## in order to print longer numbers more nicely, we can als wrap long
## lines just before we reach the end of the terminal width

use strict;
use warnings;
use feature 'say';

my $dimensions = `stty size`;
chomp($dimensions);
my ($rows, $columns) = split /\s+/, $dimensions;

my $MAX_LEN = $columns // 80;
$MAX_LEN -= 9; # make sure the last digit fits completely on the line
die "Terminal too small, try a bigger terminal" if $MAX_LEN < 10;
my @examples = (200, 1, 17, 12425, "123423509876823456567124");
my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;

foreach my $number (@examples) {
   print_number($number);
}

# print a number
sub print_number {
   my $number = shift;
   # split the number into individual digits
   my @digits = split //, $number;
   my @print;
   foreach my $digit (@digits) {
      # get the truth for the given digit
      my $truth = $truth[$digit];
      # split the truth into a list of segments that are to be set
      my @set_segments = split //, $truth;
      # but this list of segments into a hash table for easier access
      my %set = map { $_ => 1, } @set_segments;
      # now for each possible segment, check whether it is set or not
      # and append the required output to the corresponding element of
      # the output array
      if($set{"a"}) {
         $print[0] .= " ------- ";
      } else {
         $print[0] .= "         ";
      }
      if($set{"f"}) {
         $print[1] .= " |";
         $print[2] .= " |";
      } else {
         $print[1] .= "  ";
         $print[2] .= "  ";
      }
      if($set{"b"}) {
         $print[1] .= "     | ";
         $print[2] .= "     | ";
      } else {
         $print[1] .= "       ";
         $print[2] .= "       ";
      }
      if($set{"g"}) {
         $print[3] .= " ------- ";
      } else {
         $print[3] .= "         ";
      }
      if($set{"e"}) {
         $print[4] .= " |";
         $print[5] .= " |";
      } else {
         $print[4] .= "  ";
         $print[5] .= "  ";
      }
      if($set{"c"}) {
         $print[4] .= "     | ";
         $print[5] .= "     | ";
      } else {
         $print[4] .= "       ";
         $print[5] .= "       ";
      }
      if($set{"d"}) {
         $print[6] .= " ------- ";
      } else {
         $print[6] .= "         ";
      }
      # if we hit the terminal width, output
      # the digits so far and empty the array
      # again for the remaining digits
      if(length($print[0]) > $MAX_LEN) {
         foreach my $line (@print) {
            say $line;
         }
         @print = ();
      }
   }
   # print the digits
   foreach my $line (@print) {
      say $line;
   }
}
