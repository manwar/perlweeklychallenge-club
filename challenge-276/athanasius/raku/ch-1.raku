use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 276
=========================

TASK #1
-------
*Complete Day*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @hours.

Write a script to return the number of pairs that forms a complete day.

    A complete day is defined as a time duration that is an exact multiple of
    24 hours.

Example 1

  Input: @hours = (12, 12, 30, 24, 24)
  Output: 2

  Pair 1: (12, 12)
  Pair 2: (24, 24)

Example 2

  Input: @hours = (72, 48, 24, 5)
  Output: 3

  Pair 1: (72, 48)
  Pair 2: (72, 24)
  Pair 3: (48, 24)

Example 3

  Input: @hours = (12, 18, 24)
  Output: 0

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. Hours are unsigned integers; negative hours are excluded.
2. The pair (0, 0) is accepted as a "complete day" because it meets the
   definition: "a time duration that is an exact multiple of 24 hours."

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If an explanation of the output is required, the flag "--verbose" is entered
   on the command-line.
3. The input hours are entered as a non-empty list of unsigned integers at the
   tail of the command-line.

=end comment
#===============================================================================

use Test;

my UInt constant DAY      = 24;
my UInt constant HALF-DAY = (DAY / 2).floor;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 276, Task #1: Complete Day (Raku)\n".put;
}

#-------------------------------------------------------------------------------
class DayPair
#-------------------------------------------------------------------------------
{
    has UInt $.lhs;
    has UInt $.rhs;

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    submethod TWEAK                                               # Sanity check
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    {
        ($!lhs + $!rhs) % DAY == 0 or die 'Invalid DayPair';
    }
}

#===============================================================================
multi sub MAIN
(
    #| Explain the output?

    Bool:D :$verbose = False,

    #| A non-empty list of unsigned integers

    *@hours where { .elems > 0 && .all ~~ UInt:D }
)
#===============================================================================
{
    "Input:  \@hours = (%s)\n".printf: @hours.join: ', ';

    my DayPair @pairs = find-day-pairs( @hours );
    my UInt    $count = @pairs.elems;

    "Output: $count".put;

    if $verbose && $count > 0
    {
        put();
        my UInt $n = 1;

        "Pair %d: (%d, %d)\n".printf( $n++, .lhs, .rhs ) for @pairs;
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-day-pairs( List:D[UInt:D] $hours --> List:D[DayPair:D] )
#-------------------------------------------------------------------------------
{
    my DayPair     @pairs;
    my Array[UInt] @sorted-hours = Array[UInt].new xx DAY;

    for @$hours -> UInt $hour
    {
        my $mod = $hour % DAY;

        @sorted-hours[ $mod ].push: $hour.Int;      # Prevent creation of IntStr
    }

    @pairs.push: |pair-identical-mods( @sorted-hours[     0    ] );     # Mod  0
    @pairs.push: |pair-identical-mods( @sorted-hours[ HALF-DAY ] );     # Mod 12

    for 1 .. @sorted-hours.end -> UInt $i
    {
        next if $i == HALF-DAY;

        @sorted-hours[ $i ] = Array[UInt].new: @sorted-hours[ $i ].unique.sort;
    }

    @pairs.push: |pair-complementary-mods( @sorted-hours );

    @pairs .= sort: { $^b.lhs <=> $^a.lhs || $^b.rhs <=> $^a.rhs };

    return @pairs;
}

#-------------------------------------------------------------------------------
sub pair-identical-mods( List:D[UInt:D] $hours --> List:D[DayPair:D] )
#-------------------------------------------------------------------------------
{
    my DayPair @pairs;

    if $hours.elems >= 2
    {
        my UInt @hours = $hours.sort: { $^b <=> $^a };
        my UInt $last-lhs;

        for 0 .. @hours.end - 1 -> UInt $i
        {
            my UInt $lhs = @hours[ $i ];

            next if $last-lhs.defined && $last-lhs == $lhs;

            my UInt $last-rhs;

            for $i + 1 .. @hours.end -> UInt $j
            {
                my UInt $rhs = @hours[ $j ];

                next if $last-rhs.defined && $last-rhs == $rhs;

                @pairs.push: DayPair.new: :$lhs, :$rhs;

                $last-rhs = $rhs;
            }

            $last-lhs = $lhs;
        }
    }

    return @pairs;
}

#-------------------------------------------------------------------------------
sub pair-complementary-mods
(
    List:D[List:D[UInt:D]] $sorted-hours
--> List:D[DayPair:D]
)
#-------------------------------------------------------------------------------
{
    my DayPair @pairs;

    for 1 .. HALF-DAY - 1 -> UInt $i
    {
        for |@$sorted-hours[ $i ] -> UInt $left
        {
            my UInt $j = DAY - $i;

            for |@$sorted-hours[ $j ] -> UInt $right
            {
                my UInt ($lhs, $rhs) = ($left > $right) ?? ($left, $right)
                                                        !! ($right, $left);
                @pairs.push: DayPair.new: :$lhs, :$rhs;
            }
        }
    }

    return @pairs;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $hours-str, $expected-str) = $line.split: / \| /;

        for     $test-name, $hours-str, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt    @hours = int-split( $hours-str );
        my DayPair @pairs = find-day-pairs( @hours );
        my DayPair @expected;

        for $expected-str.split: / \; \s* /, :skip-empty -> Str $pair-str
        {
            my UInt ($lhs, $rhs) = int-split( $pair-str );

            @expected.push: DayPair.new: :$lhs, :$rhs;
        }

        is-deeply @pairs, @expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub int-split( Str:D $str --> Seq:D[Int:D] )
#-------------------------------------------------------------------------------
{
    return $str.split( / \s+ /, :skip-empty ).map: { .Int };
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
    my Str $data = q:to/END/;
        Example 1|12 12 30 24 24           |24 24; 12 12
        Example 2|72 48 24  5              |72 48; 72 24; 48 24
        Example 3|12 18 24                 |
        1-off    | 1 23 25 47 49 71 23 23  |71 49; 71 25; 71  1; 49 47; 49 23; \
                                            47 25; 47  1; 25 23; 23  1
        7-off    | 7 17 17 31 65           |65 31; 65  7; 31 17; 17  7
        Combined |65  1 31 23 17 25 7 47 71|71 25; 71  1; 65 31; 65  7; 47 25; \
                                            47  1; 31 17; 25 23; 23  1; 17  7
        END

    $data ~~ s:g/ \\ \n \s* / /;                 # Concatenate backslashed lines

    return $data;
}

################################################################################
