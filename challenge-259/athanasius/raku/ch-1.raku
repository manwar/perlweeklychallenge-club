use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 259
=========================

TASK #1
-------
*Banking Day Offset*

Submitted by: Lee Johnson

You are given a start date and offset counter. Optionally you also get bank
holiday date list.

Given a number (of days) and a start date, return the number (of days) adjusted
to take into account non-banking days. In other words: convert a banking day
offset to a calendar day offset.

Non-banking days are:

 a) Weekends
 b) Bank holidays

Example 1

 Input: $start_date = '2018-06-28', $offset = 3, $bank_holidays = ['2018-07-03']
 Output: '2018-07-04'

 Thursday bumped to Wednesday (3 day offset, with Monday a bank holiday)

Example 2

 Input: $start_date = '2018-06-28', $offset = 3
 Output: '2018-07-03'

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. Offsets are non-negative.
2. If the start date is a non-banking day, offset 0 is the first banking day
   after the start date.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The first command-line argument is a starting date, represented by a string
   in the format "YYYY-MM-DD" (ISO 8601).
3. The second command-line argument is an unsigned integer offset.
4. The third command-line argument is optional. If present, it is a string com-
   prising "YYYY-MM-DD" strings representing the dates of bank holidays. These
   date strings are separated by whitespace and/or commas.

=end comment
#===============================================================================

use Test;

my UInt constant SATURDAY = 6;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 259, Task #1: Banking Day Offset (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D  $start-date,           #= Start date in 'YYYY-MM-DD' format
    UInt:D $offset,               #= Non-negative offset in days
    Str:_  $bank-holidays?        #= Optional string: list of bank holiday dates
)
#===============================================================================
{
    my Str @holiday-strs;

    if $bank-holidays.defined
    {
        @holiday-strs = $bank-holidays.split: / <[ \s \, ]>+ /, :skip-empty;

        ("Input:  \$start-date    =  '$start-date'\n" ~
         "        \$offset        =   $offset\n"      ~
         "        \@bank-holidays = [%s]\n\n").printf:
                   @holiday-strs.map( { "'$_'" } ).join: ', ';
    }
    else
    {
        ("Input:  \$start-date = '$start-date'\n" ~
         "        \$offset     =  $offset\n").put;
    }

    my (Date $start, Set[Date] $holidays) =
        parse-date-strings( $start-date, @holiday-strs );

    my Date $day = find-banking-day( $start, $offset, $holidays );

    "Output: '%s'\n".printf: $day.Str;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-banking-day
(
    Date:D        $start-date,
    UInt:D        $offset,
    Set:D[Date:D] $bank-holidays
--> Date:D
)
#-------------------------------------------------------------------------------
{
    my Date $day = $start-date;

    # 1. Advance, if necessary, to the first banking day ("day zero")

    ++$day until is-banking-day( $day, $bank-holidays );

    # 2. Advance (a further) $offset number of banking days

    loop (my UInt $count = $offset; $count > 0;)
    {
        --$count if is-banking-day( ++$day, $bank-holidays );
    }

    return $day;
}

#-------------------------------------------------------------------------------
sub is-banking-day( Date:D $date, Set:D[Date:D] $bank-holidays --> Bool:D )
#-------------------------------------------------------------------------------
{
    return $date.day-of-week < SATURDAY &&                  # Monday to Friday
           $date ∉ $bank-holidays;                          # Not a bank holiday
}

#-------------------------------------------------------------------------------
sub parse-date-strings
(
    Str:D         $start-date-str,
    List:D[Str:D] $bank-holiday-strs
--> List:D[Date:D, Set:D[Date:D]]
)
#-------------------------------------------------------------------------------
{
    CATCH
    {
        when X::Temporal { error( .message ); }
    }

    my Date      $start-date    = Date.new: $start-date-str;
    my Set[Date] $bank-holidays = Set[Date].new:
                                  $bank-holiday-strs.map: { Date.new: $_ };

    return $start-date, $bank-holidays;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $start-str, $offset, $holidays-str, $expected-str) =
                $line.split: / \| /;

        for     $test-name, $start-str, $offset, $holidays-str, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str @holiday-strs =
               $holidays-str.split: / <[ \s \, ]>+ /, :skip-empty;

        my (Date $start, Set[Date] $holidays) =
            parse-date-strings( $start-str, @holiday-strs );

        my Date $day      = find-banking-day( $start, $offset.Int, $holidays );
        my Date $expected = Date.new: $expected-str;

        is $day, $expected, $test-name;
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
    # 28 June 2018 was a Thursday

    return q:to/END/;
        Example 1    |2018-06-28|3|2018-07-03           |2018-07-04
        Example 2    |2018-06-28|3|                     |2018-07-03
        2 holidays   |2018-06-28|3|2018-07-03 2018-07-04|2018-07-05
        Zero offset 1|2018-06-28|0|                     |2018-06-28
        Zero offset 2|2018-06-28|0|2018-06-28           |2018-06-29
        Zero offset 3|2018-06-30|0|                     |2018-07-02
        Weekend start|2018-06-30|1|                     |2018-07-03
        Holiday start|2018-06-28|1|2018-06-28           |2018-07-02
        END
}

################################################################################
