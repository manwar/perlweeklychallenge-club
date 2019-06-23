use v6;

################################################################################
=begin comment

Perl Weekly Challenge 013
=========================

Challenge #1
------------

Write a script to print the date of last *Friday* of every month of a given
year. For example, if the given year is *2019* then it should print the follow-
ing:

2019/01/25
2019/02/22
2019/03/29
2019/04/26
2019/05/31
2019/06/28
2019/07/26
2019/08/30
2019/09/27
2019/10/25
2019/11/29
2019/12/27

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use DateTime:from<Perl5>;

my Int constant $DAYS_IN_WEEK   :=    7;
my Int constant $DEFAULT_YEAR   := 2019;
my Int constant $FEBRUARY_INDEX :=    1;
my     constant @DAYS_IN_MONTH  := Array[Int].new: 31, 28, 31, 30, 31, 30,
                                                   31, 31, 30, 31, 30, 31;
my     constant @OFFSET_1ST_FRI := Array[Int].new:  4,  3,  2,  1,  0,  6,  5;

sub MAIN(Int:D $year = $DEFAULT_YEAR)
{
    my $dt    = DateTime.new( :$year, month => 1, day => 1 );
    my $first = 1 + @OFFSET_1ST_FRI[ $dt.day_of_week - 1 ];
    my @days  = @DAYS_IN_MONTH;
     ++@days[ $FEBRUARY_INDEX ] if $dt.is_leap_year;

    say "\nLast Fridays in each month of $year:\n";

    for 1 .. 12 -> Int $month
    {
        my $days  = @days[ $month - 1 ];
        my $last  = $first;
           $last += $DAYS_IN_WEEK until $last > $days;
           $first = $last - $days;
           $last -= $DAYS_IN_WEEK;

        printf "%4d/%02d/%02d\n", $year, $month, $last;
    }
}

################################################################################
