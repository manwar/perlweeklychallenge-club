use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 364
=========================

TASK #1
-------
*Decrypt String*

Submitted by: Mohammad Sajid Anwar

You are given a string formed by digits and '#'.

Write a script to map the given string to English lowercase characters following
the given rules.

  - Characters 'a' to 'i' are represented by '1' to '9' respectively.
  - Characters 'j' to 'z' are represented by '10#' to '26#' respectively.

Example 1

  Input: $str = "10#11#12"
  Output: "jkab"

  10# -> j
  11# -> k
  1   -> a
  2   -> b

Example 2

  Input: $str = "1326#"
  Output: "acz"

  1   -> a
  3   -> c
  26# -> z

Example 3

  Input: $str = "25#24#123"
  Output: "yxabc"

  25# -> y
  24# -> x
  1   -> a
  2   -> b
  3   -> c

Example 4

  Input: $str = "20#5"
  Output: "te"

  20# -> t
  5   -> e

Example 5

  Input: $str = "1910#26#"
  Output: "aijz"

  1   -> a
  9   -> i
  10# -> j
  26# -> z

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
If the input string is valid (because it is composed of digits and hash charac-
ters only), any characters which fall outside of the mapping rules are left un-
mapped in the output string. For example:

1. "0123" --> "0abc" because digit zero in this string is not part of a hash
   construct and has no mapping as an independent character.
2. "127#" --> "abg#" because "27#" is not a valid hash construct.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string of one or more characters is entered on the command-line. The char-
   acters must be digits ("0" to "9") or the hash character "#".

=end comment
#===============================================================================

use Test;

subset Input  of Str where * ~~ / ^ <[ 0..9 #   ]>+ $ /;
subset Output of Str where * ~~ / ^ <[ a..z # 0 ]>+ $ /;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 364, Task #1: Decrypt String (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Input:D $str           #= A string composed of digits and the hash character
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my Output $decrypted-str = decrypt-string( $str );

    qq[Output: "$decrypted-str"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub decrypt-string( Input:D $input --> Output:D )
#-------------------------------------------------------------------------------
{
    my Str $hash = '#';
    my Str $str  = $input;

    while $str ~~ m/ (\d) (\d) $hash /
    {
        my Str  $rep;
        my UInt $val = ($0 ~ $1).Int;

        if 26 >= $val >= 10
        {
            $rep = decrypt-value( $val );
        }
        else
        {
            $rep = decrypt-value( +$0 ) ~ decrypt-value( +$1 ) ~ '#';
        }

        $str ~~ s/ $val $hash /$rep/;
    }

    return TR/1..9/a..i/ given $str;
}

#-------------------------------------------------------------------------------
sub decrypt-value( UInt $value --> Str:D )
#-------------------------------------------------------------------------------
{
    return (ord( 'a' ) + $value - 1).chr;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $expected) = $line.split: / \| /;

        for     $test-name, $str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Output $decrypted-str = decrypt-string( $str );

        is $decrypted-str, $expected, $test-name;
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
        Example 1   |10#11#12 |jkab
        Example 2   |1326#    |acz
        Example 3   |25#24#123|yxabc
        Example 4   |20#5     |te
        Example 5   |1910#26# |aijz
        Assumption 1|0123     |0abc
        Assumption 2|127#     |abg#
        END
}

################################################################################
