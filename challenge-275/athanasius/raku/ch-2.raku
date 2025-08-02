use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 275
=========================

TASK #2
-------
*Replace Digits*

Submitted by: Mohammad Sajid Anwar

You are given an alphanumeric string, $str, where each character is either a
letter or a digit.

Write a script to replace each digit in the given string with the value of the
previous letter plus (digit) places.

Example 1

  Input: $str = 'a1c1e1'
  Output: 'abcdef'

  shift('a', 1) => 'b'
  shift('c', 1) => 'd'
  shift('e', 1) => 'f'

Example 2

  Input: $str = 'a1b2c3d4'
  Output: 'abbdcfdh'

  shift('a', 1) => 'b'
  shift('b', 2) => 'd'
  shift('c', 3) => 'f'
  shift('d', 4) => 'h'

Example 3

  Input: $str = 'b2b'
  Output: 'bdb'

Example 4

  Input: $str = 'a16z'
  Output: 'abgz'

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. The input string must begin with a letter.
2. Case is maintained when replacing digits. For example, in "a1" the "1" is
   replaced with "b", but in "A1" the "1" is replaced with "B".
3. Replacement letters "wrap" around from "z" back to "a". For example, in "v9"
   the "9" is replaced with "e" (counting 9 places from "v": w-x-y-z-a-b-c-d-e).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A single alphanumeric string, beginning with a letter, is entered as an
   unnamed (positional) argument on the command-line.

=end comment
#===============================================================================

use Test;

my UInt constant LETTERS = 'Z'.ord - 'A'.ord + 1;

my regex alpha    {     :i <[ a .. z ]>     }
my regex digit    {        <[ 0 .. 9 ]>     }
my regex alphanum {   <alpha> || <digit>    }
my regex string   { ^ <alpha> <alphanum>* $ }

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 275, Task #2: Replace Digits (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str where / <string> /     #= An alphanumeric string beginning with a
                                      #= letter
)
#===============================================================================
{
    "Input: \$str = '$str'".put;

    my Str $replaced = replace-digits( $str );

    "Output:       '$replaced'".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub replace-digits( Str:D $str where / <string> / --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str @chars     = $str.split: '', :skip-empty;
    my Str $last-char = @chars[ 0 ];

    for 1 .. @chars.end -> UInt $i
    {
        my Str $char = @chars[ $i ];

        if $char ~~ / <alpha> /
        {
            $last-char = $char;
        }
        else
        {
            my Str  $max-char = ('A' le $last-char le 'Z') ?? 'Z' !! 'z';
            my UInt $new-ord  = $last-char.ord + $char;
                    $new-ord -= LETTERS if $new-ord > $max-char.ord;

            @chars[ $i ] = $new-ord.chr;
        }
    }

    return @chars.join: '';
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

        my Str $replaced = replace-digits( $str );

        is $replaced, $expected, $test-name;
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
        Example 1 |a1c1e1   |abcdef
        Example 2 |a1b2c3d4 |abbdcfdh
        Example 3 |b2b      |bdb
        Example 4 |a16z     |abgz
        Digit zero|a0e0i0o0u|aaeeiioou
        Wrap uc   |W57      |WBD
        Wrap lc   |w57      |wbd
        END
}

################################################################################
