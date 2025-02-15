use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 308
=========================

TASK #2
-------
*Decode XOR*

Submitted by: Mohammad Sajid Anwar

You are given an encoded array and an initial integer.

Write a script to find the original array that produced the given encoded array.
It was encoded such that encoded[i] = orig[i] XOR orig[i + 1].

Example 1

  Input: @encoded = (1, 2, 3), $initial = 1
  Output: (1, 0, 2, 1)

  Encoded array created like below, if the original array was (1, 0, 2, 1)
  $encoded[0] = (1 xor 0) = 1
  $encoded[1] = (0 xor 2) = 2
  $encoded[2] = (2 xor 1) = 3

Example 2

  Input: @encoded = (6, 2, 7, 3), $initial = 4
  Output: (4, 2, 0, 7, 4)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. The initial integer is unsigned, and the elements of the encoded list are
   also unsigned integers.
2. The XOR operation is bitwise XOR, not logical XOR.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The initial unsigned integer is entered on the command-line, followed by a
   non-empty list of encoded unsigned integers.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 308, Task #2: Decode XOR (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| An initial unsigned integer

    UInt:D $initial,

    #| A non-empty list of unsigned integers

    *@encoded where { .elems > 0 && .all ~~ UInt:D }
)
#===============================================================================
{
    "Input:  \@encoded = (%s), \$initial = %d\n".printf: @encoded.join( ', ' ),
                                                         $initial;
    my UInt @decoded = decode-xor( @encoded, $initial );

    "Output: (%s)\n".printf: @decoded.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub decode-xor( List:D[UInt:D] $encoded, UInt:D $initial --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my UInt @decoded = +$initial; 
    my UInt $last    =  $initial +^ $encoded[ 0 ];

    @decoded.push: $last;

    for 1 .. $encoded.end -> UInt $i
    {
        $last +^= $encoded[ $i ];

        @decoded.push: $last;
    }

    return @decoded;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $enc-str, $initial, $exp-str) = $line.split: / \| /;

        for     $test-name, $enc-str, $initial, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt @encoded = $enc-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt @expectd = $exp-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt @decoded = decode-xor( @encoded, $initial.Int );

        is-deeply @decoded, @expectd, $test-name;
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
        Example 1|1 2 3  |1|1 0 2 1
        Example 2|6 2 7 3|4|4 2 0 7 4
        END
}

################################################################################
