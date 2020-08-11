use v6;

################################################################################
=begin comment

Perl Weekly Challenge 030
=========================

Task #1
-------
Write a script to list dates for Sunday Christmas between 2019 and 2100. For
example, 25 Dec 2022 is Sunday.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

my UInt constant $START-YEAR    = 2019;
my UInt constant $END-YEAR      = 2100;
my UInt constant $DECEMBER      =   12;
my UInt constant $CHRISTMAS-DAY =   25;
my UInt constant $SUNDAY        =    7;
my Str  constant $FORMAT        = 'Between %d and %d (inclusive), Christmas ' ~
                                  "Day (%dth December) falls on a\nSunday "   ~
                                  "in %s, and %s\n";

BEGIN say '';

#===============================================================================
sub MAIN()
#===============================================================================
{
    my UInt @years;

    for $START-YEAR .. $END-YEAR -> UInt $year
    {
        my Date $date = Date.new($year, $DECEMBER, $CHRISTMAS-DAY);

        @years.push: $year if $date.day-of-week == $SUNDAY;
    }

    my UInt $final-year = @years.pop;

    $FORMAT.printf:
        $START-YEAR, $END-YEAR, $CHRISTMAS-DAY, @years.join(', '), $final-year;
}

################################################################################
