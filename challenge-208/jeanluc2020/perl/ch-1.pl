#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-208/#TASK1
#
# Task 1: Minimum Index Sum
# =========================
#
# You are given two arrays of strings.
#
# Write a script to find out all common strings in the given two arrays with minimum index sum. If no common strings found returns an empty list.
#
## Example 1
##
## Input: @list1 = ("Perl", "Raku", "Love")
##        @list2 = ("Raku", "Perl", "Hate")
##
## Output: ("Perl", "Raku")
##
## There are two common strings "Perl" and "Raku".
## Index sum of "Perl": 0 + 1 = 1
## Index sum of "Raku": 1 + 0 = 1
#
## Example 2
##
## Input: @list1 = ("A", "B", "C")
##        @list2 = ("D", "E", "F")
##
## Output: ()
##
## No common string found, so no result.
#
## Example 3
##
## Input: @list1 = ("A", "B", "C")
##        @list2 = ("C", "A", "B")
##
## Output: ("A")
##
## There are three common strings "A", "B" and "C".
## Index sum of "A": 0 + 1 = 1
## Index sum of "B": 1 + 2 = 3
## Index sum of "C": 2 + 0 = 2
#
############################################################
##
## discussion
##
############################################################
#
# We have to find the index for every string in both arrays.
# Then we find the index sum for each string.
# Then we find the minimum value for the sums.
# Then we output every string that has this minimum value as its sum.

use strict;
use warnings;
use List::Util qw(min);

index_sum( ["Perl", "Raku", "Love"], ["Raku", "Perl", "Hate"] );
index_sum( ["A", "B", "C"], ["D", "E", "F"] );
index_sum( ["A", "B", "C"], ["C", "A", "B"] );

sub index_sum {
   my ($l1, $l2) = @_;
   my @list1 = @$l1;
   my @list2 = @$l2;
   my @result = ();
   my $index_data = {};
   print "Input: (" . join(", ", @list1) . "); (" . join(", ", @list2) . ")\n";
   # find the index for every string in list1
   foreach my $i (0..$#list1) {
      my $value = $list1[$i];
      $index_data->{$value}->{"list1_index"} = $i;
   }
   # find the index for every string in list2
   foreach my $j (0..$#list2) {
      my $value = $list2[$j];
      $index_data->{$value}->{"list2_index"} = $j;
   }
   # for each found string, if it exists in both lists, calculate the sum
   my @sums = ();
   foreach my $v (keys %$index_data) {
      if(defined($index_data->{$v}->{"list1_index"})
         && defined($index_data->{$v}->{"list2_index"})) {
         $index_data->{$v}->{"sum"} =
                $index_data->{$v}->{"list1_index"}
                + $index_data->{$v}->{"list2_index"};
         push @sums, $index_data->{$v}->{"sum"};
      }
   }
   # calculate the minimum sum
   my $minimum = min(@sums);
   # find all values that share the minimum index sum
   foreach my $v (keys %$index_data) {
      if(defined($index_data->{$v}->{"sum"})) {
         if($index_data->{$v}->{"sum"} == $minimum) {
            push @result, $v;
         }
      }
   }
   # in order to avoid a random sort order of the results we sort by
   # their index in list1
   print "Output: (" . join(", ",
      sort {
         $index_data->{ $a }->{"list1_index"} <=>
         $index_data->{ $b }->{"list1_index"} }
      @result) . ")\n";
}
