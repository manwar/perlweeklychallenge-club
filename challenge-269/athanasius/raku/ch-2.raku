use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 269
=========================

TASK #2
-------
*Distribute Elements*

Submitted by: Mohammad Sajid Anwar

You are given an array of distinct integers, @ints.

Write a script to distribute the elements as described below:

  1) Put the 1st element of the given array to a new array @arr1.
  2) Put the 2nd element of the given array to a new array @arr2.

Once you have one element in each arrays, @arr1 and @arr2, then follow the rule
below:

  If the last element of the array @arr1 is greater than the last
  element of the array @arr2 then add the first element of the
  given array to @arr1 otherwise to the array @arr2.

When done distribution, return the concatenated arrays. @arr1 and @arr2.

Example 1

  Input: @ints = (2, 1, 3, 4, 5)
  Output: (2, 3, 4, 5, 1)

  1st operation:
  Add 1 to @arr1 = (2)

  2nd operation:
  Add 2 to @arr2 = (1)

  3rd operation:
  Now the last element of @arr1 is greater than the last element
  of @arr2, add 3 to @arr1 = (2, 3).

  4th operation:
  Again the last element of @arr1 is greate than the last element
  of @arr2, add 4 to @arr1 = (2, 3, 4)

  5th operation:
  Finally, the last element of @arr1 is again greater than the last
  element of @arr2, add 5 to @arr1 = (2, 3, 4, 5)

  Mow we have two arrays:
  @arr1 = (2, 3, 4, 5)
  @arr2 = (1)

  Concatenate the two arrays and return the final array: (2, 3, 4, 5, 1).

Example 2

  Input: @ints = (3, 2, 4)
  Output: (3, 4, 2)

  1st operation:
  Add 1 to @arr1 = (3)

  2nd operation:
  Add 2 to @arr2 = (2)

  3rd operation:
  Now the last element of @arr1 is greater than the last element
  of @arr2, add 4 to @arr1 = (3, 4).

  Now we have two arrays:
  @arr1 = (3, 4)
  @arr2 = (2)

  Concatenate the two arrays and return the final array: (3, 4, 2).

Example 3

  Input: @ints = (5, 4, 3, 8)
  Output: (5, 3, 4, 8)

  1st operation:
  Add 1 to @arr1 = (5)

  2nd operation:
  Add 2 to @arr2 = (4)

  3rd operation:
  Now the last element of @arr1 is greater than the last element
  of @arr2, add 3 to @arr1 = (5, 3).

  4th operation:
  Again the last element of @arr2 is greate than the last element
  of @arr1, add 8 to @arr2 = (4, 8)

  Now we have two arrays:
  @arr1 = (5, 3)
  @arr2 = (4, 8)

  Concatenate the two arrays and return the final array: (5, 3, 4, 8).

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input integers are entered on the command-line.
3. If the first integer is negative, it must be preceded by "--" to indicate
   that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 269, Task #2: Distribute Elements (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of distinct integers

    *@ints where { .elems > 0 && .all ~~ Int:D && are-distinct( @ints ) }
)
#===============================================================================
{
    "Input: \@ints = (%s)\n".printf: @ints.join: ', ';

    my  Int  @soln = distribute-elements( @ints );

    "Output:        (%s)\n"\.printf: @soln.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub distribute-elements
(
    List:D[Int:D] $ints where { .elems > 0 && are-distinct( $ints ) }
--> List:D[Int:D]
)
#-------------------------------------------------------------------------------
{
    my Int @ints = @$ints;                    # Make a copy
    my Int @arr1 = @ints.shift;
    my Int @arr2 = @ints.shift if @ints;

    while @ints
    {
        my Int @target := @arr1[ *-1 ] > @arr2[ *-1 ] ?? @arr1 !! @arr2;

        @target.push: @ints.shift;
    }

    return @arr1.append: @arr2;
}

#-------------------------------------------------------------------------------
sub are-distinct( List:D[Int:D] $ints --> Bool:D )
#-------------------------------------------------------------------------------
{
    my UInt %dict{Int};

    for @$ints
    {
        return False if ++%dict{ $_ } > 1;
    }

    return True;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $expd-str) = $line.split: / \| /;

        for     $test-name, $ints-str, $expd-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @ints = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };

        are-distinct( @ints );

        my Int @soln = distribute-elements( @ints );
        my Int @expd = $expd-str.split( / \s+ /, :skip-empty ).map: { .Int };

        is-deeply @soln, @expd, $test-name;
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
        Example 1| 2 1  3 4 5| 2 3 4  5 1
        Example 2| 3 2  4    | 3 4 2
        Example 3| 5 4  3 8  | 5 3 4  8
        Singleton|17         |17
        Negatives|-1 1 -2 2  |-1 2 1 -2
        END
}

################################################################################
