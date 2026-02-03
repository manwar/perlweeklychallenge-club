use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 358
=========================

TASK #2
-------
*Encrypted String*

Submitted by: Mohammad Sajid Anwar

You are given a string $str and an integer $int.

Write a script to encrypt the string using the algorithm - for each character
$char in $str, replace $char with the $int th character after $char in the
alphabet, wrapping if needed and return the encrypted string.

Example 1

  Input: $str = "abc", $int = 1
  Output: "bcd"

Example 2

  Input: $str = "xyz", $int = 2
  Output: "zab"

Example 3

  Input: $str = "abc", $int = 27
  Output: "bcd"

Example 4

  Input: $str = "hello", $int = 5
  Output: "mjqqt"

Example 5

  Input: $str = "perl", $int = 26
  Output: "perl"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. The input plaintext ($str) comprises letters from the English alphabet only.
   Both upper and lower case letters are allowed.
2. The input offset ($int) may take any integer value:
   - a value of 0 leaves the input text unchanged;
   - a value greater than 25 is treated as ($int mod 26);
   - a negative value greater than -26 is treated as positive offset
     (26 + $int) -- i.e., as the |$int|th letter *earlier* in the alphabet;
   - a negative value less than -25 is treated as positive offset
     (26 - (|$int| mod 26)).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string of letters (from the English alphabet only) is entered on the
   command-line, followed by an integer.

=end comment
#===============================================================================

use Test;

my constant @ALPHABET = Array[Str].new: 'a' .. 'z';

subset Alpha of Str where * ~~ rx/ :i ^ <{ @ALPHABET.join: '||' }>* $ /;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 358, Task #2: Encrypted String (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Alpha:D $str,             #= A string of alphabetic characters
    Int:D   $int              #= An integer
)
#===============================================================================
{
    qq[Input:  \$str = "$str", \$int = $int].put;

    my Str $encrypted = encrypt( $str, $int.Int );

    qq[Output: "$encrypted"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub encrypt( Alpha:D $str, Int:D $int --> Str:D )
#-------------------------------------------------------------------------------
{
    my UInt $count =  @ALPHABET.elems;
    my Str  $plain =  @ALPHABET.join;
    my Str  $crypt = ($plain ~ $plain).substr: $int mod $count, $count;
            $plain =  $plain.uc ~ $plain.lc;
            $crypt =  $crypt.uc ~ $crypt.lc;

    return $str.trans: $plain => $crypt;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $int, $expected) = $line.split: / \| /;

        for     $test-name, $str, $int, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $encrypted = encrypt( $str, $int.Int );

        is $encrypted, $expected, $test-name;
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
        Example 1|abc  |  1|bcd
        Example 2|xyz  |  2|zab
        Example 3|abc  | 27|bcd
        Example 4|hello|  5|mjqqt
        Example 5|perl | 26|perl
        Cases    |AbCdE| 17|RsTuV
        Negative |bcdef| -1|abcde
        Plaintext|Plain|  0|Plain
        Wrap +ve |Pyis | 28|Raku
        Wrap -ve |Pyis |-50|Raku
        END
}

################################################################################
