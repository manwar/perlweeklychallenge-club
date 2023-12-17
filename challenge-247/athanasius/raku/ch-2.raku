use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 247
=========================

TASK #2
-------
*Most Frequent Letter Pair*

Submitted by: Jorg Sommrey

You are given a string S of lower case letters 'a'..'z'.

Write a script that finds the pair of consecutive letters in S that appears most
frequently. If there is more than one such pair, choose the one that is the
lexicographically first.

Example 1

  Input: $s = 'abcdbca'
  Output: 'bc'

  'bc' appears twice in `$s`

Example 2

  Input: $s = 'cdeabeabfcdfabgcd'
  Output: 'ab'

  'ab' and 'cd' both appear three times in $s and 'ab' is lexicographically
  smaller than 'cd'.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If VERBOSE is set to True, a short explanation is appended to the output.

=end comment
#===============================================================================

use Test;

my Bool constant VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 246, Task #2: Most Frequent Letter Pair (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A string of two or more lower case letters ('a' .. 'z')

    Str:D $s where { / ^ <[ a .. z ]> ** 2..* $ / }
)
#===============================================================================
{
    "Input:  \$s = '$s'".put;

    my (UInt $max-freq, Array[Str] $pairs) = find-max-pairs( $s );

    "Output: '%s'\n".printf: $pairs[ 0 ];

    if VERBOSE
    {
        "\nExplanation:\nThe maximum pair frequency is $max-freq".put;

        "Letter pairs appearing with a frequency of %d: %s\n".printf:
            $max-freq, $pairs.map( { "'$_'" } ).join: ', ';
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-max-pairs
(
    Str:D $s where { / ^ <[ a .. z ]> ** 2..* $ / }
--> List:D[UInt:D, List:D[Str:D]]
)
#-------------------------------------------------------------------------------
{
    my UInt %pairs{Str};
          ++%pairs{ $s.substr: $_, 2 } for 0 .. $s.chars - 2;

    my UInt $max-freq  = %pairs.values.max;
    my Str  @max-pairs = %pairs.keys.grep( { %pairs{ $_ } == $max-freq } ).sort;

    return  $max-freq, @max-pairs;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $s, $exp-pair, $exp-freq, $exp-pairs-str) =
                $line.split: / \| /;

        for     $test-name, $s, $exp-pair, $exp-freq, $exp-pairs-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my (UInt $max-freq, Array[Str] $pairs) = find-max-pairs( $s );

        my  Str  @exp-pairs = $exp-pairs-str.split: / \s+ /;

        is        $pairs[ 0 ], $exp-pair,  "$test-name: output";
        is        $max-freq,   $exp-freq,  "$test-name: max frequency";
        is-deeply $pairs,      @exp-pairs, "$test-name: max freq pairs";
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
        Example 1  |abcdbca          |bc|2|bc
        Example 2  |cdeabeabfcdfabgcd|ab|3|ab cd
        Alternating|ababababa        |ab|4|ab ba
        Singletons |vutsrqponmlkj    |kj|1|kj lk ml nm on po qp rq sr ts ut vu
        Block      |xxxxxxxxxx       |xx|9|xx
        END
}

################################################################################
