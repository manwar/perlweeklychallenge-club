#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 231-2.
Written by Robbie Hatley on Fri Aug 25, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 2: Senior Citizens
Submitted by: Mohammad S Anwar
You are given a list of passenger details in the form “9999999999A1122”,
where 9 denotes the phone number, A the sex, 1 the age, and 2 the seat number.
Write a script to return the count of all senior citizens (persons with
age >= 60).

Example 1:
Input: @list = ("7868190130M7522","5303914400F9211","9273338290F4010")
Ouput: 2
(The age of the passengers in the given list are 75, 92 and 40, so we
have only 2 senior citizens.)

Example 2:
Input: @list = ("1313579440F2036","2921522980M5644")
Ouput: 0
(All passengers have age < 60.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
My approach to solving this was, for each "detail", increment a counter each time an age 60+ is seen:
"my $senior_count = 0; map {++$senior_count if (0 + substr $_, 11, 2) >= 60} @$aref;

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
double-quoted array of arrays of 15-character strings, with with 12th and 13th characters being an age,
in proper Perl syntax, like so:
./ch-2.pl "(['3067238673M3273','9275624306F0927'],['2950628685M8406','9093748696M9784'])"

Output is to STDOUT and will be each input array followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:

use v5.38;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

sub count_seniors ($aref) {
   my $senior_count = 0;
   map {++$senior_count if (0 + substr $_, 11, 2) >= 60} @$aref;
   return $senior_count;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Default inputs:
my @arrays =
(
   ["7868190130M7522","5303914400F9211","9273338290F4010"],
   ["1313579440F2036","2921522980M5644"],
);

# Non-default inputs:
@arrays = eval($ARGV[0]) if @ARGV;

# Main loop:
for my $aref (@arrays) {
   say '';
   say "array = (", join(', ', map {"\"$_\""} @$aref), ")";
   say "senior count = ", count_seniors($aref);
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.0fµs.\n", $µs);
