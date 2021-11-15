use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 138
=========================

TASK #1
-------
*Workdays*

Submitted by: Mohammad S Anwar

You are given a year, $year in 4-digits form.

Write a script to calculate the total number of workdays in the given year.

    For the task, we consider, Monday - Friday as workdays.

Example 1

 Input: $year = 2021
 Output: 261

Example 2

 Input: $year = 2020
 Output: 262

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------
A common year has 365 days, a leap year 366. 52 weeks is 364 days, and those 52
weeks are guaranteed to contain (52 * 5) = 260 "workdays". So the total number
of workdays in the year is determined by whether the extra days -- 1 in a
common year, or 2 in a leap year -- fall on or between weekends.

If a year begins on a Monday, then the final day of the 52-week block of days
must be a Sunday: in which case, the following day(s) fall between weekends. A
similar reasoning is easily applied to the other days of the week. For example,
if the year begins on a Sunday, then the final day of the 52-week block of days
must be a Saturday, and therefore the following day falls on a Sunday, and does
NOT add to the total of workdays; but the day after that (if this is a leap
year) falls on a Monday and DOES add to the total.

In the solution below, these extra days have been pre-computed and stored in
the constant arrays @COMMON and @LEAP-Y. The inbuilt Raku Date class is used to
determine the day of the week on which the first day of the year falls, and
also whether or not the year is a leap year. (Note that Date's day-of-week()
method returns an Int in the range 1 to 7, with 1 being Monday. This number is
decremented to facilitate its use as an index into the @COMMON and @LEAP-Y
arrays.)

=end comment
#==============================================================================

my UInt constant $BASE   = 260;                                        # 52 * 5
my      constant @COMMON = Array[Int].new: 1, 1, 1, 1, 1, 0, 0;
my      constant @LEAP-Y = Array[Int].new: 1, 1, 1, 1, 0, 0, 1;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 138, Task #1: Workdays (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $year where 1 <= $year <= 9999              #= Year in 4-digits form
)
#==============================================================================
{
    "Input:  \$year = %d\n".printf: $year.UInt;                     # Normalize

    my Date $dt-jan1   = Date.new: $year, 1, 1;
    my UInt $day-of-wk = $dt-jan1.day-of-week - 1;
    my UInt $workdays  = @COMMON[ $day-of-wk ] + $BASE;
            $workdays += @LEAP-Y[ $day-of-wk ] if $dt-jan1.is-leap-year;

    "Output: $workdays".put;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

##############################################################################
