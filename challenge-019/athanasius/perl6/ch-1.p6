use v6;

################################################################################
=begin comment

Perl Weekly Challenge 019
=========================

Task #1
-------
Write a script to display months from the year 1900 to 2019 where you find 5
weekends i.e. 5 Friday, 5 Saturday and 5 Sunday.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

my UInt constant $FIRST-YEAR = 1900;
my UInt constant $LAST-YEAR  = 2019;
my UInt constant $FRIDAY     =    5;
my UInt constant $TARGET-DAY =   29;
my      constant %MONTHS     =    1 =>  'January',
                                  3 =>    'March',
                                  5 =>      'May',
                                  7 =>     'July',
                                  8 =>   'August',
                                 10 =>  'October',
                                 12 => 'December';

sub MAIN()
{
    my UInt $count = 0;

    for $FIRST-YEAR .. $LAST-YEAR -> UInt $year
    {
        my @months;

        for %MONTHS.keys.sort( {.Int} ) -> Str $month
        {
            my Date $date = Date.new($year, $month.Int, $TARGET-DAY);

            if $date.day-of-week == $FRIDAY
            {
                push @months, %MONTHS{$month};
                ++$count;
            }
        }

        say "$year: ", join(' and ', @months) if @months.elems > 0;
    }

    say "\nTotal: $count months";
}

################################################################################
