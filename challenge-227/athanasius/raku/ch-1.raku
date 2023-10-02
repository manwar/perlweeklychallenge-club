use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 227
=========================

TASK #1
-------
*Friday 13th*

Submitted by: Peter Campbell Smith

You are given a year number in the range 1753 to 9999.

Write a script to find out how many dates in the year are Friday 13th, assume
that the current Gregorian calendar applies.

Example

  Input: $year = 2023
  Output: 2

  Since there are only 2 Friday 13th in the given year 2023 i.e. 13th Jan and
  13th Oct.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to True, the solution (the number of dates) is followed by
   a list of the months in the given year in which the 13th is a Friday.

Note
----
"Friday the 13th .... occurs when the 13th day of the month in the Gregorian
calendar falls on a Friday, which happens at least once every year but can occur
up to three times in the same year." --"Friday the 13th", Wikipedia

=end comment
#===============================================================================

use Date::Names;
use Test;

my UInt constant $FRIDAY  = 5;    # Date::day-of-week() outputs 1-7, Monday is 1
my UInt constant $MIN     = 1753;
my UInt constant $MAX     = 9999;
my Bool constant $VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 227, Task #1: Friday 13th (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    UInt:D $year where $MIN <= * <= $MAX     #= A year in the range 1753 to 9999
)
#===============================================================================
{
    "Input:  \$year = $year".put;

    my Str  @list  = find-friday_13th( $year );
    my UInt $count = @list.elems;

    "Output: $count".put;

    if $VERBOSE
    {
        "\nMonth%s in %d in which 13th falls on a Friday: %s\n".printf:
            $count == 1 ?? '' !! 's', $year, @list.join: ', ';
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-friday_13th( UInt:D $year where $MIN <= * <= $MAX --> List:D[Str:D] )
#-------------------------------------------------------------------------------
{
    my Date::Names $dn = Date::Names.new: :lang< en >, :mset< mon3 >;
    my Str         @list;

    for 1 .. 12 -> UInt $month
    {
        my Date $date = Date.new: year => $year, month => $month, day => 13;
        my UInt $dow  = $date.day-of-week;

        @list.push: $dn.mon( $month ) if $dow == $FRIDAY;
    }

    return @list;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test, $year, $exp-count, $exp-list-str) = $line.split: / \| /;

        for     $test, $year, $exp-count, $exp-list-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str  @exp-list = $exp-list-str.split: / \s+ /;
        my Str  @list     = find-friday_13th( $year.Int );
        my UInt $count    = @list.elems;

        is        $count, $exp-count.Int, "$test: count";
        is-deeply @list,  @exp-list,      "$test: months";
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example    |2023|2|Jan Oct
        Wikipedia 1|2015|3|Feb Mar Nov
        Wikipedia 2|1960|1|May
        Wikipedia 3|1900|2|Apr Jul
        Wikipedia 4|2099|3|Feb Mar Nov
        END
}

################################################################################
