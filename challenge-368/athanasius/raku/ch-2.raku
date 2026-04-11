use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 368
=========================

TASK #2
-------
*Big and Little Omega*

Submitted by: Roger Bell_West

You are given a positive integer $number and a mode flag $mode. If the mode flag
is zero, calculate little omega (the count of all distinct prime factors of that
number). If it is one, calculate big omega (the count of all prime factors
including duplicates).

Example 1

  Input: $number = 100061
         $mode = 0
  Output: 3

  Prime factors are 13, 43, 179. Count is 3.

Example 2

  Input: $number = 971088
         $mode = 0
  Output: 3

  Prime factors are 2, 2, 2, 2, 3, 20231. Count of distinct numbers is 3.

Example 3

  Input: $number = 63640
         $mode = 1
  Output: 6

  Prime factors are 2, 2, 2, 5, 37, 43. Count including duplicates is 6.

Example 4

  Input: $number = 988841
         $mode = 1
  Output: 2

Example 5

  Input: $number = 211529
         $mode = 0
  Output: 2

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
2. A positive integer is entered on the command-line, followed by a string which
   is either "0" or "1".
3. If the constant VERBOSE is set to True, the output count is followed by a
   list of the prime factors of the input number.

=end comment
#===============================================================================

use Prime::Factor;
use Test;

subset Result of List where (UInt, List);

my UInt constant VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 368, Task #2: Big and Little Omega (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    UInt:D $number where * > 0,              #= A positive integer
    Str:D  $mode   where / ^ <[ 0 1 ]> $ /   #= A mode string, either "0" or "1"
)
#===============================================================================
{
    "Input:  \$number = $number".put;
    "        \$mode   = $mode".put;

    my (UInt        $count,
        Array[UInt] $factors) = count-prime-factors( $number, $mode );

    "Output: $count".put;

    "\nPrime factors: %s\n".printf( $factors.join: ', ' ) if VERBOSE;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-prime-factors
(
    UInt:D $number where * > 0,
    Str:D  $mode   where / ^ <[ 0 1 ]> $ /
--> Result:D
)
#-------------------------------------------------------------------------------
{
    my UInt @factors = prime-factors( $number );
    my UInt $count   = $mode eq '0' ?? @factors.unique.elems      # Little omega
                                    !! @factors.elems;            # Big    omega

    return [$count, @factors];
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $number, $mode, $exp-count, $exp-factors-str) =
                $line.split: / \| /;

        for     $test-name, $number, $mode, $exp-count, $exp-factors-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my (UInt $count, Array[UInt] $factors) =
                                count-prime-factors( $number.Int, $mode );
        my  UInt @exp-factors = $exp-factors-str.split( / \s+ /, :skip-empty )
                                                .map: { .Int };

        is        $count,   $exp-count.Int, "$test-name: count";
        is-deeply $factors, @exp-factors,   "$test-name: factors";
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    exit 0;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|100061|0|3|13 43 179
        Example 2|971088|0|3|2 2 2 2 3 20231
        Example 3| 63640|1|6|2 2 2 5 37 43
        Example 4|988841|1|2|7 141263
        Example 5|211529|0|2|37 5717
        END
}

################################################################################
