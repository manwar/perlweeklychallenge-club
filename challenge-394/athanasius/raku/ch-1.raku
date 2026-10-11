use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 394
=========================

TASK #1
-------
*Alternate Case*

Submitted by: Mohammad Sajid Anwar

You are given a string containing an equal number of uppercase and lowercase
English letters.

Write a script to [find] the minimum number of adjacent character swaps needed
to turn the given string into an alternate case string.

Example 1

  Input: $str = "aAbB"
  Output: 0

Example 2

  Input: $str = "AAbb"
  Output: 1

  Swap 1: "AbAb"

Example 3

  Input: $str = "AAAbbb"
  Output: 3

  Swap 1: "AAbAbb"
  Swap 2: "AbAAbb"
  Swap 3: "AbAbAb"

Example 4

  Input: $str = "aABb"
  Output: 1

  Swap 1: "aAbB"

Example 5

  Input: $str = "bBBAaa"
  Output: 2

  Swap 1: "BbBAaa"
  Swap 2: "BbBaAa"

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
2. A string, containing an equal number of uppercase and lowercase English
   letters, is entered on the command-line.

=end comment
#===============================================================================

use Test;

enum Case < UPPER-CASE LOWER-CASE >;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 394, Task #1: Alternate Case (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A string of an equal number of upper- & lowercase English letters

    Str:D $str where { is-valid-str( $str ) }
)
#===============================================================================
{
    "Input:  \$str = $str".put;

    my UInt $min-swaps = find-min-swaps( $str );

    qq[Output: $min-swaps].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-min-swaps( Str:D $str where { is-valid-str( $str ) } --> UInt:D )
#-------------------------------------------------------------------------------
{
    return 0 if is-alt-case-str( $str );

    my Str @strs = $str;

    loop (my UInt $swaps = 1; ; ++$swaps)
    {
        my Str @new-strs;

        for @strs -> Str $s
        {
            my UInt @swap-idxs = find-swaps( $s );

            for @swap-idxs -> UInt $i
            {
                my Str $new-str = swap( $s, $i );

                return $swaps if is-alt-case-str( $new-str );

                @new-strs.push: $new-str;
            }
        }

        @strs = @new-strs;
    }
}

#-------------------------------------------------------------------------------
sub find-swaps( Str:D $str --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my Str  @chars = $str.split: '', :skip-empty;
    my UInt @indices;

    for 0 .. @chars.end - 1 -> UInt $i
    {
        my Case $lhs = get-case( @chars[$i    ] );
        my Case $rhs = get-case( @chars[$i + 1] );

        @indices.push: $i if $lhs !== $rhs;
    }

    return @indices;
}

#-------------------------------------------------------------------------------
sub swap( Str:D $str, UInt:D $i --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str @chars  = $str.split: '', :skip-empty;
    my Str $temp   = @chars[$i];

    @chars[$i    ] = @chars[$i + 1];
    @chars[$i + 1] = $temp;

    return @chars.join: '';
}

#-------------------------------------------------------------------------------
sub is-valid-str( Str:D $str --> Bool:D )
#-------------------------------------------------------------------------------
{
    return False unless $str ~~ m:i/ ^ <[ A .. Z ]>* $ /;

    my UInt $uc = 0;

    for $str.split( '', :skip-empty ) -> Str $char
    {
        ++$uc if get-case( $char ) == UPPER-CASE;
    }

    return $uc * 2 == $str.chars;
}

#-------------------------------------------------------------------------------
sub is-alt-case-str( Str:D $str --> Bool:D )
#-------------------------------------------------------------------------------
{
    return True if $str.chars < 2;

    my Str  @chars = $str.split: '', :skip-empty;
    my Case $last  = get-case( @chars[0] );

    for 1 .. @chars.end -> UInt $i
    {
        my Case $current = get-case( @chars[$i] );

        return False if $current == $last;

        $last = $current;
    }

    return True;
}

#-------------------------------------------------------------------------------
sub get-case( Str:D $str --> Case:D )
#-------------------------------------------------------------------------------
{
    return 'A' le $str le 'Z' ?? UPPER-CASE !! LOWER-CASE;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $expected) = $line.split: '|';

        for     $test-name, $str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt $min-swaps = find-min-swaps( $str );

        is $min-swaps, $expected.Int, $test-name;
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
        Example 1|aAbB  |0
        Example 2|AAbb  |1
        Example 3|AAAbbb|3
        Example 4|aABb  |1
        Example 5|bBBAaa|2
        END
}

################################################################################
