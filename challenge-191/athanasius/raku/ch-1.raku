use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 191
=========================

TASK #1
-------
*Twice Largest*

Submitted by: Mohammad S Anwar

You are given list of integers, @list.

Write a script to find out whether the largest item in the list is at least
twice as large as each of the other items.

Example 1

  Input: @list = (1,2,3,4)
  Output: -1

  The largest in the given list is 4. However 4 is not greater than twice of
  every remaining elements.
  1 x 2 < 4
  2 x 2 > 4
  2 x 3 > 4

Example 2

  Input: @list = (1,2,0,5)
  Output: 1

  The largest in the given list is 5. Also 5 is greater than twice of every
  remaining elements.
  1 x 2 < 5
  2 x 2 < 5
  0 x 2 < 5

Example 3

  Input: @list = (2,6,3,1)
  Output: 1

  The largest in the given list is 6. Also 6 is greater than twice of every
  remaining elements.
  2 x 2 < 6
  3 x 2 < 6
  1 x 2 < 6

Example 4

  Input: @list = (4,5,2,3)
  Output: -1

  The largest in the given list is 5. Also 5 is not greater than twice of every
  remaining elements.
  4 x 2 > 5
  2 x 2 < 5
  3 x 2 > 5

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Note: If the first argument is negative, it must be preceded by "--" to dis-
      tinguish it from a command-line flag.

=end comment
#==============================================================================

use Test;

my UInt constant $TEST-FIELDS = 3;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 191, Task #1: Twice Largest (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    #| A list of two or more integers

    *@list where { .elems >= 2 && .all ~~ Int:D }
)
#==============================================================================
{
    "Input:  @list = (%s)\n".printf: @list.join: ',';
    "Output: %d\n".printf: twice-largest( @list );
}

#==============================================================================
multi sub MAIN()                                 # No input: run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub twice-largest( Array:D[Int:D] $list --> Int:D )
#------------------------------------------------------------------------------
{
    my Int @ordered = $list.sort: { $^b leg $^a };    # Sort numeric descending
    my Int $largest = @ordered[ 0 ];
    my Int $next    = @ordered[ 1 ];

    return $largest >= (2 * $next) ?? 1 !! -1;
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $in, $expected) =
            $line.split: / \, \s* /, $TEST-FIELDS;

        my Int @list = $in.split( / \s+ /, :skip-empty ).map: { .Int };

        is twice-largest( @list ), $expected.Int, $test-name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub test-data()
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1, 1 2 3 4, -1
        Example 2, 1 2 0 5,  1
        Example 3, 2 6 3 1,  1
        Example 4, 4 5 2 3, -1
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
