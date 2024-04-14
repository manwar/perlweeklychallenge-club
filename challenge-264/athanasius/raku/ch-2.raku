use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 264
=========================

TASK #2
-------
*Target Array*

Submitted by: Mohammad Sajid Anwar

You are given two arrays of integers, @source and @indices. The @indices can
only contains integers 0 <= i < size of @source.

Write a script to create target array by insert at index $indices[i] the value
$source[i].

Example 1

  Input: @source  = (0, 1, 2, 3, 4)
         @indices = (0, 1, 2, 2, 1)
  Output: (0, 4, 1, 3, 2)

  @source  @indices  @target
  0        0         (0)
  1        1         (0, 1)
  2        2         (0, 1, 2)
  3        2         (0, 1, 3, 2)
  4        1         (0, 4, 1, 3, 2)

Example 2

  Input: @source  = (1, 2, 3, 4, 0)
         @indices = (0, 1, 2, 3, 0)
  Output: (0, 1, 2, 3, 4)

  @source  @indices  @target
  1        0         (1)
  2        1         (1, 2)
  3        2         (1, 2, 3)
  4        3         (1, 2, 3, 4)
  0        0         (0, 1, 2, 3, 4)

Example 3

  Input: @source  = (1)
         @indices = (0)
  Output: (1)

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
2. The lists $source and $indices are entered as named-argument strings on the
   command-line.
 - Each is a list of integers separated by whitespace.
 - $indices contains unsigned integers (i, j, k, ...) such that each is less
   than or equal to its own index position in the list: i = 0, 0 <= j <= 1,
   0 <= k <= 2, etc.

=end comment
#===============================================================================

use Test;

subset MainArgs of List where (Array[Int], Array[UInt]);

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 264, Task #2: Target Array (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D :$source,          #= A whitespace-separated list of integers
    Str:D :$indices          #= A whitespace-separated list of positive integers
)
#===============================================================================
{
    my MainArgs $args = parse-command-line( $source, $indices );

    "Input:  \@source  = (%s)\n".printf: $args[ 0 ].join: ', ';
    "        \@indices = (%s)\n".printf: $args[ 1 ].join: ', ';

    my Int @target = construct-target( $args );

    "Output: \@target  = (%s)\n".printf: @target.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub construct-target( MainArgs:D $args --> List:D[Int:D] )
#-------------------------------------------------------------------------------
{
    my Int @target;

    for 0 .. $args[ 0 ].end -> UInt $i
    {
        @target.splice( $args[ 1; $i ], 0, $args[ 0; $i ] );
    }

    return @target;
}

#-------------------------------------------------------------------------------
sub parse-command-line( Str:D $source, Str:D $indices --> MainArgs:D )
#-------------------------------------------------------------------------------
{
    my Int @source;

    for $source.split( / \s+ /, :skip-empty ) -> Str $s
    {
        +$s ~~ Int     or error( qq["$s" is not a valid integer] );

        @source.push: +$s;
    }

    my UInt @indices;
    my UInt $count = 0;

    for $indices.split( / \s+ /, :skip-empty ) -> Str $i
    {
       +$i ~~ Int      or error( qq["$i" is not a valid integer] );
        $i >= 0        or error( qq["$i" is negative] );
        $i <= $count++ or error( qq[The index "$i" is too large] );

        @indices.push: +$i;
    }

    @source.elems == @indices.elems
                       or error( 'The input lists are of different sizes' );

    return @source, @indices;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $source-str, $indices-str, $expected-str) =
                $line.split: / \| /;

        for     $test-name, $source-str, $indices-str, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int  @source   = parse-list( $source-str );
        my UInt @indices  = parse-list( $indices-str );
        my Int  @expected = parse-list( $expected-str );
        my Int  @target   = construct-target( [ @source, @indices ] );

        is-deeply @target, @expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub parse-list( Str:D $string --> List:D[Int:D] )
#-------------------------------------------------------------------------------
{
    return $string.split( / \s+ /, :skip-empty ).map( { .Int } ).list;
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
        Example 1|0 1 2 3 4|0 1 2 2 1|0 4 1 3 2
        Example 2|1 2 3 4 0|0 1 2 3 0|0 1 2 3 4
        Example 3|1        |0        |1
        END
}

################################################################################
