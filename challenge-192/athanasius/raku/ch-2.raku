use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 192
=========================

TASK #2
-------
*Equal Distribution*

Submitted by: Mohammad S Anwar

You are given a list of integers greater than or equal to zero, @list.

Write a script to distribute the number so that each members are same. If you
succeed then print the total moves otherwise print -1.

Please follow the rules (as suggested by Neils van Dijke [2022-11-21 13:00])

  1) You can only move a value of '1' per move
  2) You are only allowed to move a value of '1' to a direct neighbor/adjacent
     cell

Example 1:

  Input: @list = (1, 0, 5)
  Output: 4

  Move #1: 1, 1, 4
  (2nd cell gets 1 from the 3rd cell)

  Move #2: 1, 2, 3
  (2nd cell gets 1 from the 3rd cell)

  Move #3: 2, 1, 3
  (1st cell gets 1 from the 2nd cell)

  Move #4: 2, 2, 2
  (2nd cell gets 1 from the 3rd cell)

Example 2:

  Input: @list = (0, 2, 0)
  Output: -1

  It is not possible to make each same.

Example 3:

  Input: @list = (0, 3, 0)
  Output: 2

  Move #1: 1, 2, 0
  (1st cell gets 1 from the 2nd cell)

  Move #2: 1, 1, 1
  (3rd cell gets 1 from the 2nd cell)

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run.
2. To show (one possible version of) the actual moves, set $VERBOSE to True.
   (This has no effect on the running of the test suite.)

Algorithm
---------
sum  := sum of all the list elements
size := number of elements in the list
IF sum is evenly divisible by size THEN
    target := sum / size
    move   := 0
    WHILE list elements are not all equal
        low  := index of first element less    than target
        high := index of first element greater than target
        # Implement one move:
        increment the element beside element[high] on the side closest to
            element[low]
        decrement element[high]
        increment move
    ENDWHILE
    RETURN move
ELSE
    RETURN -1
ENDIF

=end comment
#==============================================================================

use Test;

my UInt constant $TST-FLDS = 3;
my Bool constant $VERBOSE  = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 192, Task #2: Equal Distribution (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    #| A non-empty list of non-negative integers

    *@list where { .elems > 0 && .all ~~ UInt:D } 
)
#==============================================================================
{
    "Input:  \@list = (%s)\n".printf: @list.join: ', ';

    "Output: %d\n".printf: count-moves( True, @list );
}

#==============================================================================
multi sub MAIN()                                           # Run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub count-moves
(
    Bool:D $display,
          *@list where { .elems > 0 && .all ~~ UInt:D }
--> Int:D
)
#------------------------------------------------------------------------------
{
    my UInt $size = @list.elems;
    my Int  $move = -1;                 # Assume failure
    my UInt $sum  = [+] @list;

    if $sum %% $size                    # Solution is possible
    {
        $move = 0;

        my UInt $target = ($sum / $size).Int;

        until distribution-is-equal( $target, @list )
        {
            my UInt $low  = get-idx-low\( $target, @list );
            my UInt $high = get-idx-high( $target, @list );

            ++@list[ $high + (($low < $high) ?? -1 !! 1) ];
            --@list[ $high ];
            ++$move;

            if $VERBOSE && $display
            {
                "       Move %2d: (%s)\n".printf: $move, join ', ', @list;
            }
        }
    }

    return $move;
}

#------------------------------------------------------------------------------
sub distribution-is-equal
(
    UInt:D $target,
          *@list where { .elems > 0 && .all ~~ UInt:D }
--> Bool:D
)
#------------------------------------------------------------------------------
{
    for @list -> UInt $n
    {
        return False unless $n == $target;
    }

    return True;
}

#------------------------------------------------------------------------------
sub get-idx-low
(
    UInt:D $target,
          *@list where { .elems > 0 && .all ~~ UInt:D }
--> UInt:D
)
#------------------------------------------------------------------------------
{
    for 0 .. @list.end -> UInt $i
    {
        return $i if @list[ $i ] < $target;
    }

    die 'No low index found';
}

#------------------------------------------------------------------------------
sub get-idx-high
(
    UInt:D $target,
          *@list where { .elems > 0 && .all ~~ UInt:D }
--> UInt:D
)
#------------------------------------------------------------------------------
{
    for 0 .. @list.end -> UInt $i
    {
        return $i if @list[ $i ] > $target;
    }

    die 'No high index found';
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $in, $expected) =
            $line.split: / \, \s* /, $TST-FLDS, :skip-empty;

        my UInt @list = $in.split( / \s+ /, :skip-empty ).map: { .Int };

        is count-moves( False, @list ), $expected.Int, $test-name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub test-data( --> Str:D )
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1,     1 0 5,            4
        Example 2,     0 2 0,           -1
        Example 3,     0 3 0,            2
        Bubble left,   4 5 6  7 8 9 10, 28
        Bubble right, 10 9 8  7 6 5  4, 28
        Middle,        4 9 5 10 8 6  7,  8
        Fully centred, 1 1 1  8 1 1  1, 12
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
