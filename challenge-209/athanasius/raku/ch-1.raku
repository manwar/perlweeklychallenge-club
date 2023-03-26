use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 209
=========================

TASK #1
-------
*Special Bit Characters*

Submitted by: Mohammad S Anwar

You are given an array of binary bits that ends with 0.

Valid sequences in the bit string are:

  [0] -decodes-to-> "a"
  [1, 0] -> "b"
  [1, 1] -> "c"

Write a script to print 1 if the last character is an “a” otherwise print 0.

Example 1

  Input: @bits = (1, 0, 0)
  Output: 1

  The given array bits can be decoded as 2-bits character (10) followed by 1-bit
  character (0).

Example 2

  Input: @bits = (1, 1, 1, 0)
  Output: 0

  Possible decode can be 2-bits character (11) followed by 2-bits character (10)
  i.e. the last character is not 1-bit character.

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
2. If $VERBOSE is True, the required output (1 or 0) is followed by the decoded
   text.

=end comment
#===============================================================================

use Test;

my Bool constant $VERBOSE = True;

subset Bit of Int where 0 | 1;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 209, Task #1: Special Bit Characters (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $bits where / ^ <[01]>* 0 $ /   #= A string of binary bits ending in 0
)
#===============================================================================
{
    my Bit @bits = $bits.split( '', :skip-empty ).map: { .Int };

    "Input:  \@bits = (%s)\n".printf: @bits.join: ', ';

    my (Str $text, Bit $output) = decode( @bits );

    "Output: $output".put;

    "\nDecoded string: $text".put if $VERBOSE;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub decode( List:D[Bit:D] $bits --> List:D[Str:D, Bit:D] )
#-------------------------------------------------------------------------------
{
    my Bit @bits = @$bits;        # Make a copy
    my Str $text;

    while @bits
    {
        my Bit $bit0 = @bits.shift;

        if $bit0 == 0
        {
            $text ~= 'a';
        }
        else
        {
            my Bit $bit1 = @bits.shift;

            $text ~= $bit1 == 0 ?? 'b' !! 'c';
        }
    }

    return $text, $text ~~ / a $ / ?? 1 !! 0;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $input, $expected) = $line.split: / \| /;

        $test-name ~~ s/ \s+ $ //;
        $input     ~~ s/ \s+ $ //;

        my  Bit @bits = $input.split( '', :skip-empty ).map: { .Int };
        my (Str $text,
            Bit $out) = decode( @bits );
        my  Str $got  = "$text=$out";

        is $got, $expected, $test-name;
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
        Example 1|100           |ba=1
        Example 2|1110          |cb=0
        Longer   |11101001101000|cbbacabaa=1
        END
}

################################################################################
