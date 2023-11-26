use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 238
=========================

TASK #2
-------
*Persistence Sort*

Submitted by: Mohammad S Anwar

You are given an array of positive integers.

Write a script to sort the given array in increasing order with respect to the
count of steps required to obtain a single-digit number by multiplying its
digits recursively for each array element. If any two numbers have the same
count of steps, then print the smaller number first.

Example 1

  Input: @int = (15, 99, 1, 34)
  Output: (1, 15, 34, 99)

  15 => 1 x 5 => 5 (1 step)
  99 => 9 x 9 => 81 => 8 x 1 => 8 (2 steps)
  1  => 0 step
  34 => 3 x 4 => 12 => 1 x 2 => 2 (2 steps)

Example 2

  Input: @int = (50, 25, 33, 22)
  Output: (22, 33, 50, 25)

  50 => 5 x 0 => 0 (1 step)
  25 => 2 x 5 => 10 => 1 x 0 => 0 (2 steps)
  33 => 3 x 3 => 9 (1 step)
  22 => 2 x 2 => 4 (1 step)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
A "positive" integer is an unsigned integer (i.e., an integer >= 0).

Interface
---------
If no command-line arguments are given, the test suite is run.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 238, Task #2: Persistence Sort (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of positive integers

    *@ints where { .elems > 0 && .all ~~ UInt:D }
)
#===============================================================================
{
    my UInt @sorted = persistence-sort( @ints );
    my Str (@ints-str, @sort-str);

    for 0 .. @ints.end -> UInt $i
    {
        my UInt $width = max( @ints[ $i ].chars, @sorted[ $i ].chars );

        @ints-str.push: '%*s'.sprintf: $width, @ints\ [ $i ];
        @sort-str.push: '%*s'.sprintf: $width, @sorted[ $i ];
    }

    "Input: \@int = (%s)\n".printf: @ints-str.join: ', ';
    "Output:       (%s)\n"\.printf: @sort-str.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub persistence-sort( List:D[UInt:D] $ints --> Seq:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    return $ints.sort: { count-steps( $^a ) <=> count-steps( $^b ) ||
                                      $^a   <=>   $^b };
}

#-------------------------------------------------------------------------------
sub count-steps( UInt:D $num --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $steps   = 0;
    my UInt $product = $num;

    while $product.chars > 1
    {
        my UInt @digits = $product.split( '', :skip-empty ).map: { .Int };

        $product = [*] @digits;
        ++$steps;
    }

    return $steps;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $int-str, $exp-str) = $line.split: / \| /;

        for     $test-name, $int-str, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt @ints     = $int-str.split( / \s+ / ).map: { .Int };
        my UInt @expected = $exp-str.split( / \s+ / ).map: { .Int };
        my UInt @sorted   = persistence-sort( @ints );

        is-deeply @sorted, @expected, $test-name;
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
        Example 1|15 99  1 34| 1 15 34 99
        Example 2|50 25 33 22|22 33 50 25
        END
}

################################################################################
