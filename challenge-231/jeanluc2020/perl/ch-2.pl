#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-231/#TASK2
#
# Task 2: Senior Citizens
# =======================
#
# You are given a list of passenger details in the form “9999999999A1122”, where 9 denotes the phone number, A the sex, 1 the age and 2 the seat number.
#
# Write a script to return the count of all senior citizens (age >= 60).
#
## Example 1
##
## Input: @list = ("7868190130M7522","5303914400F9211","9273338290F4010")
## Ouput: 2
##
## The age of the passengers in the given list are 75, 92 and 40.
## So we have only 2 senior citizens.
#
## Example 2
##
## Input: @list = ("1313579440F2036","2921522980M5644")
## Ouput: 0
#
############################################################
##
## discussion
##
############################################################
#
# The data format has a few problems here. Not only is the
# telephone number fixed length, the same is true for the age
# (I guess people are not allowed to be older than 99 years here)
# and the seat number.
# In our case, we're only interested in the age really, so we
# can pick the last four characters, from which we pick the first
# two characters.

senior_citizens("7868190130M7522","5303914400F9211","9273338290F4010");
senior_citizens("1313579440F2036","2921522980M5644");

sub senior_citizens {
   my @list = @_;
   print "Input: (" . join(", ", @list) . ")\n";
   my $seniors = 0;
   foreach my $elem (@list) {
      my ($tel, $age_seat) = split /[MF]/, $elem;
      my $age = substr($age_seat, 0, 2);
      $seniors++ if $age >= 60;
   }
   print "Output: $seniors\n";
}
