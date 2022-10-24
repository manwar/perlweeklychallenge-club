use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 187
=========================

TASK #1
-------
*Days Together*

Submitted by: Mohammad S Anwar

Two friends, Foo and Bar gone on holidays seperately to the same city. You are
given their schedule i.e. start date and end date.

To keep the task simple, the date is in the form DD-MM and all dates belong to
the same calendar year i.e. between 01-01 and 31-12. Also the year is non-leap
year and both dates are inclusive.

Write a script to find out for the given schedule, how many days they spent
together in the city, if at all.

Example 1

  Input: Foo => SD: '12-01' ED: '20-01'
         Bar => SD: '15-01' ED: '18-01'

  Output: 4 days

Example 2

  Input: Foo => SD: '02-03' ED: '12-03'
         Bar => SD: '13-03' ED: '14-03'

  Output: 0 day

Example 3

  Input: Foo => SD: '02-03' ED: '12-03'
         Bar => SD: '11-03' ED: '15-03'

  Output: 2 days

Example 4

  Input: Foo => SD: '30-03' ED: '05-04'
         Bar => SD: '28-03' ED: '02-04'

  Output: 4 days

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
If two arguments are given on the command-line, they are parsed as strings for-
matted according to the Examples in the Task description.

If eight arguments are given on the command-line, they are processed as four
pairs of integers, each pair representing a day-of-month together with its
associated month.

If no arguments are given on the command-line, the test suite is run.

Algorithm
---------
After some sanity checking by sub validate-date(), each of the four day/month
pairs is converted to a single day-of-the-year. For example, 04-03 (1st March)
is converted to Day 63 (= 31 + 28 + 4). This facilitates further sanity check-
ing followed by date comparison in sub count-days-together() to produce the
desired solution.

=end comment
#==============================================================================

use Test;

my      constant @DAY-OF-YEAR    =   0,  31,  59,  90, 120, 151,
                                   181, 212, 243, 273, 304, 334;
my      constant @DAYS-PER-MONTH =  31,  28,  31,  30,  31,  30,
                                    31,  31,  30,  31,  30,  31;
my      constant @MONTH-NAMES    = < January   February March    April
                                     May       June     July     August
                                     September October  November December >;
my UInt constant $TEST-FIELDS    =   3;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 187, Task #1: Days Together (Raku)\n".put;
}

#==============================================================================
multi sub MAIN                                        # Input in canonical form
(
    Str:D $foo,          #= String of the form "Foo => SD: '12-01' ED: '20-01'"
    Str:D $bar           #= String of the form "Bar => SD: '15-01' ED: '18-01'"
)
#==============================================================================
{
    my UInt @data;

    $foo ~~ / ^ Foo \s \=\> \s SD\: \s \' (\d\d) \- (\d\d) \' \s
                               ED\: \s \' (\d\d) \- (\d\d) \'  $ /
        or error( 'Invalid input format for $foo' );

    @data.push: | $/.map: { .Int };

    $bar ~~ / ^ Bar \s \=\> \s SD\: \s \' (\d\d) \- (\d\d) \' \s
                               ED\: \s \' (\d\d) \- (\d\d) \'  $ /
        or error( 'Invalid input format for $bar' );

    @data.push: | $/.map: { .Int };

    solve( @data );
}

#==============================================================================
multi sub MAIN                              # Input as a simple list of numbers
(
    #| 8 integers (4 day/month pairs)

    *@data where { .elems == 8 && .all ~~ UInt:D }
)
#==============================================================================
{
    solve( @data );
}

#==============================================================================
multi sub MAIN()                                 # No input: run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub solve( List:D[UInt:D] $data )
#------------------------------------------------------------------------------
{
    for 0, 2, 4, 6 -> UInt $i
    {
        validate-date( $data[ $i ], $data[ $i + 1 ] );
    }

    ("Input:  Foo => SD: '%02d-%02d' ED: '%02d-%02d'\n" ~
     "        Bar => SD: '%02d-%02d' ED: '%02d-%02d'\n\n").printf: @$data;

    my UInt  $days = count-days-together( @$data );

    "Output: $days day%s\n".printf: $days == 1 ?? '' !! 's';
}

#------------------------------------------------------------------------------
sub validate-date( UInt:D $day, UInt:D $month )
#------------------------------------------------------------------------------
{
    1 <= $month <= 12
        or error( qq{Invalid month "$month"} );

    1 <= $day <= @DAYS-PER-MONTH[ $month - 1 ]
        or error( qq{$day is not a valid day for @MONTH-NAMES[ $month - 1 ]} );
}

#------------------------------------------------------------------------------
sub count-days-together( List:D[UInt:D] $data --> UInt:D )
#------------------------------------------------------------------------------
{
    my UInt $foo-sd = @DAY-OF-YEAR[ $data[ 1 ] - 1 ] + $data[ 0 ];
    my UInt $foo-ed = @DAY-OF-YEAR[ $data[ 3 ] - 1 ] + $data[ 2 ];
    my UInt $bar-sd = @DAY-OF-YEAR[ $data[ 5 ] - 1 ] + $data[ 4 ];
    my UInt $bar-ed = @DAY-OF-YEAR[ $data[ 7 ] - 1 ] + $data[ 6 ];

    $foo-sd <= $foo-ed
        or error( 'Foo\'s holiday cannot end before it starts' );

    $bar-sd <= $bar-ed
        or error( 'Bar\'s holiday cannot end before it starts' );

    my UInt $start = ($foo-sd, $bar-sd).max;
    my UInt $end   = ($foo-ed, $bar-ed).min;
    my Int  $diff  =  $end - $start;

    return  $diff >= 0 ?? $diff + 1 !! 0;
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $input, $expected) =
            $line.split: / \, \s* /, $TEST-FIELDS, :skip-empty;

        my UInt @data = $input.split( / \s+ /, :skip-empty ).map: { .Int };

        is count-days-together( @data ), $expected, $test-name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub test-data()
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1,        12 01 20 01 15 01 18 01,   4
        Example 2,        02 03 12 03 13 03 14 03,   0
        Example 3,        02 03 12 03 11 03 15 03,   2
        Example 4,        30 03 05 04 28 03 02 04,   4
        Whole year,       01 01 31 12 01 01 31 12, 365
        Smallest overlap, 15 01 22 02 22 02 17 03,   1
        END
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
