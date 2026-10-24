use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 396
=========================

TASK #2
-------
*Trionic Array*

Submitted by: Mohammad Sajid Anwar

You are given an array of integer.

Write a script to return true if the given array is Trionic otherwise return
false.

    An array is trionic if there exist indices 0 < p < q < n − 1 such that
    arr[0…p] is strictly increasing, arr[p…q] is strictly decreasing, and
    arr[q…n − 1] is strictly increasing.

Example 1

  Input: @arr = (1, 3, 5, 4, 2, 6, 8)
  Output: true

  Choose p = 2 and q = 4
  $arr[0..2] = (1, 3, 5) (strictly increasing)
  $arr[2..4] = (5, 4, 2) (strictly decreasing)
  $arr[4..6] = (2, 6, 8) (strictly increasing)

  Valid indices: 0 < p (2) < q (4) < n-1 (6).

Example 2

  Input: @arr = (1, 4, 4, 2, 1, 3, 5)
  Output: false

  The first segment (1, 4, 4) contains duplicate adjacent values, so it is not
  strictly increasing.
  No valid p and q exist to satisfy all three strictly monotonic conditions.

Example 3

  Input: @arr = (2, 10, 3, 1, 9)
  Output: true

  Choose p = 1 and q = 3.
  $arr[0..1] = (2, 10)    (strictly increasing)
  $arr[1..3] = (10, 3, 1) (strictly decreasing)
  $arr[3..4] = (1, 9)     (strictly increasing)

Example 4

  Input: @arr = (1, 2, 3, 4, 3, 2, 1)
  Output: false

  This is a standard mountain array (strictly increasing, then strictly
  decreasing).
  There is no second valley (q) that transitions back into a strictly increasing
  third segment before reaching the end of the array.

Example 5

  Input: @arr = (1, 3, 6, 4, 2, 7, 8, 4)
  Output: false

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of integers is entered on the command-line.
3. If "-v" or "--verbose" is entered as a command-line flag (along with one or
   more integers), then, if the given list is trionic, the values of p and q
   (the indices of the peak and the valley) are appended to the standard output.
4. If the first integer entered on the command-line is negative, it must be
   preceded by "--" to indicate that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

subset Result of List where (Bool:D, UInt:_, UInt:_);

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 396, Task #2: Trionic Array (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@array where { .elems > 0 && .all ~~ Int:D }, #= Non-empty list of integers

    Bool:D :v(:$verbose) = False                   #= Output p and q?
)
#===============================================================================
{
    "Input:  \@array = (%s)\n".printf: @array.join: ', ';

    my (Bool $trionic, UInt $p, UInt $q) = is-trionic( @array );

    "Output: %s\n".printf: $trionic ?? 'true' !! 'false';

    "\np (peak index) = $p and q (valley index) = $q".put
        if $verbose && $trionic;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub is-trionic( List:D[Int:D] $array where { .elems > 0 } --> Result:D )
#-------------------------------------------------------------------------------
{
    my Bool   $ascent_1 =  True;
    my Bool   $descent  =  False;
    my Result $fail     = (False, UInt, UInt);
    my UInt  ($p, $q);

    return $fail if $array.elems < 4 || $array[0] >= $array[1];

    for 1 .. $array.end - 1 -> UInt $i
    {
        my Int $diff = $array[$i] - $array[$i + 1];

        return $fail if $diff == 0;

        if $ascent_1
        {
            if $diff > 0
            {
                $ascent_1 = False;
                $descent  = True;
                $p        = $i;
            }
        }
        elsif $descent
        {
            if $diff < 0
            {
                $descent = False;
                $q       = $i;
            }
        }
        else  # ascent_2
        {
            return $fail if $diff > 0;
        }
    }

    return ($ascent_1 || $descent) ?? $fail !! (True, $p, $q);
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $array-str, $exp-trionic, $exp-p, $exp-q) =
                $line.split: '|';

        for     $test-name, $array-str, $exp-trionic, $exp-p, $exp-q
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int    @array  = $array-str.split( / \s+ /, :skip-empty )
                                      .map: { .Int };
        my Result $result = is-trionic( @array );

        if $result[0]
        {
            is 'true',      $exp-trionic, "$test-name: trionic";
            is  $result[1], $exp-p.Int,   "$test-name: p";
            is  $result[2], $exp-q.Int,   "$test-name: q";
        }
        else
        {
            is 'false',     $exp-trionic, "$test-name: trionic";
        }
    }

    done-testing;
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
        Example 1|1  3 5 4 2 6 8              |true |2|4
        Example 2|1  4 4 2 1 3 5              |false| |
        Example 3|2 10 3 1 9                  |true |1|3
        Example 4|1  2 3 4 3 2 1              |false| |
        Example 5|1  3 6 4 2 7 8 4            |false| |
        Negatives|1  2 3 4 3 2 1 0 -1 -2 3 4 5|true |3|9
        END
}

################################################################################
