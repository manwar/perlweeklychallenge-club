use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 241
=========================

TASK #2
-------
*Prime Order*

Submitted by: Mohammad S Anwar

You are given an array of unique positive integers greater than 2.

Write a script to sort them in ascending order of the count of their prime
factors, tie-breaking by ascending value.

Example 1

  Input: @int = (11, 8, 27, 4)
  Output: (11, 4, 8, 27)

  Prime factors of 11 => 11
  Prime factors of  4 => 2, 2
  Prime factors of  8 => 2, 2, 2
  Prime factors of 27 => 3, 3, 3

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
If no command-line arguments are given, the test suite is run.

=end comment
#===============================================================================

use Prime::Factor;
use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 241, Task #2: Prime Order (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of unique positive integers greater than 2

    *@int where { .elems > 0       &&       # Non-empty
                  .all   ~~ UInt:D &&       # Positive integers
                  .all   > 2       &&       # Greater than 2
                   uniq-list( @int ) }      # Unique
)
#===============================================================================
{
    "Input:  \@int = (%s)\n".printf: @int.join: ', ';

    my UInt @sorted = prime-sort( @int );

    "Output:        (%s)\n".printf: @sorted.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub prime-sort( List:D[UInt:D] $int --> Seq:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my UInt %count{UInt};
            %count{ $_ } = prime-factors( $_ ).elems for @$int;

    return $int.sort: { %count{ $^a } <=> %count{ $^b } || $^a <=> $^b };
}

#-------------------------------------------------------------------------------
sub uniq-list( List:D[UInt:D] $int --> Bool:D )
#-------------------------------------------------------------------------------
{
    return $int.elems == $int.Set.elems;
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

        my UInt @integers = $int-str.split( / \s+ / ).map: { .Int };
        my UInt @expected = $exp-str.split( / \s+ / ).map: { .Int };
        my UInt @sorted   = prime-sort( @integers );

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
        Example 1  | 11   8  27   4            | 11   4   8  27
        Seq of 200s|207 208 209 210 211 212 213|211 209 213 207 212 210 208
        END
}

################################################################################
