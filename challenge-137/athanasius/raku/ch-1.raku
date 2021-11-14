use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 137
=========================

TASK #1
-------
*Long Year*

Submitted by: Mohammad S Anwar

Write a script to find all the years between 1900 and 2100 which is a Long
Year.

    A year is Long if it has 53 weeks.

[UPDATED][2021-11-01 16:20:00]: For more information about Long Year, please
refer to [ https://en.wikipedia.org/wiki/ISO_week_date#Weeks_per_year |wiki-
pedia].

Expected Output

  1903, 1908, 1914, 1920, 1925,
  1931, 1936, 1942, 1948, 1953,
  1959, 1964, 1970, 1976, 1981,
  1987, 1992, 1998, 2004, 2009,
  2015, 2020, 2026, 2032, 2037,
  2043, 2048, 2054, 2060, 2065,
  2071, 2076, 2082, 2088, 2093,
  2099

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------

From https://en.wikipedia.org/wiki/Week#Week_52_and_53 :-

    "Week 52 and 53

    It is also possible to determine if the last week of the previous year was
    Week 52 or Week 53 as follows:

     - If January 1 falls on a Friday, then it is part of Week 53 of the
       previous year (W53-5).
     - If January 1 falls on a Saturday,
         - then it is part of Week 53 of the previous year if that is a leap
           year (W53-6),
         - and part of Week 52 otherwise (W52-6), i.e. if the previous year is
           a common year.
     - If January 1 falls on a Sunday, then it is part of Week 52 of the
       previous year (W52-7)."

Implementation
--------------
Raku's inbuilt Date class provides methods day-of-week() and is-leap-year().

=end comment
#==============================================================================

my UInt constant $START     = 1_900;
my UInt constant $END       = 2_100;
my UInt constant $YR-PER-LN =     5;
my UInt constant $FRIDAY    =     5;
my UInt constant $SATURDAY  =     6;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 137, Task #1: Long Year (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    my UInt @long-years = gather        # Note use of the gather/take construct
    {
        for $START .. $END -> UInt $year
        {
            my Date $jan1 = Date.new: $year + 1, 1, 1;
            my UInt $dow  = $jan1.day-of-week;

            if    $dow == $FRIDAY
            {
                take $year;
            }
            elsif $dow == $SATURDAY
            {
                my Date $dt = Date.new: year => $year;

                take $year if $dt.is-leap-year;
            }
        }
    }

    print-years( @long-years );
}

#------------------------------------------------------------------------------
sub print-years( Array:D[UInt:D] $long-years )
#------------------------------------------------------------------------------
{
    "There are %d long years between %d and %d inclusive:\n\n".printf:
        $long-years.elems, $START, $END;

    my UInt $idx = 0;

    while $idx + $YR-PER-LN - 1 < $long-years.end
    {
        "%s,\n".printf:
                    $long-years[ $idx .. $idx + $YR-PER-LN - 1 ].join: ', ';
        $idx += $YR-PER-LN;
    }

    printf "%s\n",  $long-years[ $idx .. $long-years.end       ].join: ', ';
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
