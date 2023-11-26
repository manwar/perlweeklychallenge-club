#!/usr/bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 237-1.
Written by Robbie Hatley on Fri Oct 06, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Seize The Day
Submitted by: Mark Anderson
Given a year, a month, a weekday of month, and a day of week
(1 (Mon) .. 7 (Sun)), print the day.

Example 1:
Input: Year = 2024, Month = 4, Weekday of month = 3, day of week = 2
Output: 16
The 3rd Tue of Apr 2024 is the 16th

Example 2:
Input: Year = 2025, Month = 10, Weekday of month = 2, day of week = 4
Output: 9
The 2nd Thu of Oct 2025 is the 9th

Example 3:
Input: Year = 2026, Month = 8, Weekday of month = 5, day of week = 3
Output: 0
There isn't a 5th Wed in Aug 2026

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I am soooooo not going to pull in all of the heavy artillery from my "day-of-week.pl" script; it's just not
needed for this. I'll use "use Time::Local 'timelocal_modern';" and "localtime" instead, and I'll use this
algorithm:
1. Start with day-of-month set to zero, then enter this loop:
2. Loop while dow-counter < weekday-of-month, else skip to step 9 below.
3. Increment day-of-month.
4. If day-of-month is now invalid, set it to 0 and exit loop.
5. Get seconds-since-epoch for current day-of-month (using "timelocal_modern")
6. Get current-day-of-week from seconds-since-epoch (using "localtime"       )
7. Increment dow-counter if current dow == target dow.
8. Loop back to step 2.
9. Print results.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument,
which must be a single-quoted array of arrays of 4 integers, with each inner array being
(year, month, weekday-of-month, day-of-week), with month and weekday-of-month being 1-indexed,
and with day-of-week being 0-indexed-except-for-Sunday-which-is-7, in proper Perl syntax, like so:
./ch-1.pl '([2023,1,5,2],[5337,8,4,5],[16847,7,3,7],[547892,5,4,4])'

Output is to STDOUT and will be each input array followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS AND MODULES USED:

use v5.38;
use strict;
use warnings;
use utf8;
use warnings FATAL => 'utf8';
use Sys::Binmode;
use Time::HiRes 'time';
use Time::Local 'timelocal_modern';

# ------------------------------------------------------------------------------------------------------------
# START TIMER:
our $t0; BEGIN {$t0 = time}

# ------------------------------------------------------------------------------------------------------------
# CONSTANTS:

my @Months
   = qw(January   February  March     April     May       June
        July      August    September October   November  December);

my @DaysOfWeek
   = qw(Sunday Monday Tuesday Wednesday Thursday Friday Saturday);

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

sub is_leap_year ($year) {
   if    ( 0 == $year%4 && 0 != $year%100 ) {return 1;}
   elsif ( 0 == $year%400                 ) {return 1;}
   else                                     {return 0;}
} # end sub is_leap_year

sub days_per_month ($year, $month) {
   state @dpm = (31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
   if ( is_leap_year($year) ) {$dpm[1]=29} else {$dpm[1]=28}
   return $dpm[$month];
} # end sub days_per_month

sub suffix ($x) {
   if    ( 1 == $x ) {return 'st'}
   elsif ( 2 == $x ) {return 'nd'}
   elsif ( 3 == $x ) {return 'rd'}
   else              {return 'th'}
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [2024,  4, 3, 2],
   [2025, 10, 2, 4],
   [2026,  8, 5, 3],
);

# Main loop:
for my $aref (@arrays) {
   my $year = $$aref[0];                                    # Year.
   my $mnth = $$aref[1]-1;                                  # Month (converted to zero-indexed).
   my $wdom = $$aref[2];                                    # Weekday-of-month (one-indexed).
   my $tdow = $$aref[3]%7;                                  # Target day-of-week (converted to zero-indexed).
   my $dyom = 0;                                            # Day-of-month counter for while loop.
   my $dowc = 0;                                            # Day-of-week  counter for while loop.
   while ( $dowc < $wdom ) {                                # Loop while dow counter < weekday-of-month.
      ++$dyom;                                              # Increment day-of-month.
      if ($dyom > days_per_month($year,$mnth) ) {           # If day-of-month becomes invalid,
         $dyom = 0;                                         # set it to zero
         last;                                              # and exit while loop.
      }
      my $epoc = timelocal_modern(0,0,0,$dyom,$mnth,$year); # Epoch (seconds since 00:00:00 on Jan 1, 1970).
      my @time = localtime($epoc);                          # Date info for epoch.
      my $cdow = $time[6];                                  # Current day-of-week.
      if ($cdow == $tdow) {++$dowc}                         # Increment counter if current dow == target dow.
   }
   say '';
   if ( 0 == $dyom ) {
      say "There are not $wdom $DaysOfWeek[$tdow]s in $Months[$mnth] $year";
   }
   else {
      my $wsuf = suffix($wdom);
      my $dsuf = suffix($dyom);
      say "The $wdom$wsuf $DaysOfWeek[$tdow] in $Months[$mnth] $year is $Months[$mnth] $dyom$dsuf";
   }
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {
   my $µs = 1000000 * (time - $t0);
   printf("\nExecution time was %.0fµs.\n", $µs);
}
__END__
