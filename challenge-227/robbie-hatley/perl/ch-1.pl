#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 227-1.
Written by Robbie Hatley on Mon Jul 24, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Friday 13th
Submitted by: Peter Campbell Smith
You are given a year number in the range 1753 to 9999. Write a script to find out how many dates in the year
are Friday 13th, assume that the current Gregorian calendar applies.

Example: Input: $year = 2023 Output: 2
Since there are only 2 Friday 13th in the given year 2023 i.e. 13th Jan and 13th Oct.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Let's use the number 0-6 to stand for days-of-week from a Sunday through the next Saturday. Because we're
only interested in years 1753+, lets use 13 December 1752 as "epoch". That was a Wednesday, so our starting
offset is 3. Then make an array to hold elements indexed from 1753 through 9999 (representing the years),
with element being a ref to an array of elements indexed 0 through 11 (representing the months), with each
inner element being "starting offset plus days elapsed from epoch to the 13th of the current month".
The starting offset 3 only has to be added once, to the entry for 13 January 1753; every subsequent month
from February 1753 through December 9999 is just the number from the previous month plus the number of days
in the previous month. Then to get the "Friday The 13th"s for each year, just take each month's number
modulo 7; each 5 is a Friday The 13th.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
double-quoted array positive integers in the range 1753-9999, in proper Perl syntax, like so:
./ch-1.pl "(1794,1846,2017,8462)"

Output is to STDOUT and will be each input year followed by the "Friday The 13th"s in that year.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:

use v5.36;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';
$"=', ';

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

sub days_in_february ($year) {
   if ( 0 == $year%100 ) {
      return ( (0 == $year%400) ? 29 : 28 );
   }
   else {
      return ( (0 == $year%4) ? 29 : 28 );
   }
}

sub days_in_month ($year, $month) {
   if    (  0 == $month ) { return 31;                      }
   elsif (  1 == $month ) { return days_in_february($year); }
   elsif (  2 == $month ) { return 31;                      }
   elsif (  3 == $month ) { return 30;                      }
   elsif (  4 == $month ) { return 31;                      }
   elsif (  5 == $month ) { return 30;                      }
   elsif (  6 == $month ) { return 31;                      }
   elsif (  7 == $month ) { return 31;                      }
   elsif (  8 == $month ) { return 30;                      }
   elsif (  9 == $month ) { return 31;                      }
   elsif ( 10 == $month ) { return 30;                      }
   elsif ( 11 == $month ) { return 31;                      }
}

sub year_is_valid ($year) {
   return 0 if $year !~ m/^[1-9]\d\d\d$/;
   return 0 if $year < 1753;
   return 1;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Array of month names:
my @month_names = qw( January February March April May June July August September October November December );

# @t = Array of thirteenths:
my @t;
$t[1752]->[11] = 3; # Starting offset is 3 because 13 December 1752 was a Wednesday.
for my $year (1753..9999) {
   for my $month (0..11) {
      if ( 0 == $month ) {
         $t[$year]->[$month] = $t[$year-1]->[11] + 31;
      }
      else {
         $t[$year]->[$month] = $t[$year]->[$month-1] + days_in_month($year,$month-1);
      }
   }
}

# Default inputs:
my @years =
(
   2022,
   2023,
   2024,
);

# Non-default inputs:
@years = eval($ARGV[0]) if @ARGV;

# Main loop:
for my $year (@years) {
   say '';
   if ( ! year_is_valid($year) ) {
      say "Year $year is invalid. Year must be in range 1753-9999.";
      next;
   }
   say "Friday the 13ths in year $year:";
   my $tcount = 0;
   for my $month (0..11) {
      if ( 5 == $t[$year]->[$month]%7 ) {
         say "Friday 13 $month_names[$month], $year";
         ++$tcount;
      }
   }
   say "Total Friday The 13ths in $year = $tcount";
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.0fµs.\n", $µs);
