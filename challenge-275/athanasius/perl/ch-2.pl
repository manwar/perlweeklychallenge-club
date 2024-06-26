#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

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

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $LETTERS  => ord( 'Z' ) - ord( 'A' ) + 1;
const my $ALPHA    => qr/   [a-z]               /ix;
const my $DIGIT    => qr/   [0-9]               /x;
const my $ALPHANUM => qr/   $ALPHA || $DIGIT    /x;
const my $STRING   => qr/ ^ $ALPHA $ALPHANUM* $ /x;
const my $USAGE    => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    An alphanumeric string beginning with a letter
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 275, Task #2: Replace Digits (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 1)
    {
        my $str =  $ARGV[ 0 ];
           $str =~ $STRING or error( 'Invalid input string' );

        print "Input: \$str = '$str'\n";

        my $replaced = replace_digits( $str );

        print "Output:       '$replaced'\n";
    }
    else
    {
        error( "Expected 0 or 1 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub replace_digits
#-------------------------------------------------------------------------------
{
    my ($str)      =  @_;
        $str       =~ $STRING or die 'Invalid string argument';
    my  @chars     =  split //, $str;
    my  $last_char =  $chars[ 0 ];

    for my $i (1 .. $#chars)
    {
        my $char = $chars[ $i ];

        if ($char =~ $ALPHA)
        {
            $last_char   = $char;
        }
        else
        {
            my $max_char = ('A' le $last_char le 'Z') ? 'Z' : 'z';
            my $new_ord  = ord( $last_char ) + $char;
               $new_ord -= $LETTERS if $new_ord > ord $max_char;

            $chars[ $i ] = chr $new_ord;
        }
    }

    return join '', @chars;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $expected) = split / \| /x, $line;

        for ($test_name, $str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $replaced = replace_digits( $str );

        is $replaced, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1 |a1c1e1   |abcdef
Example 2 |a1b2c3d4 |abbdcfdh
Example 3 |b2b      |bdb
Example 4 |a16z     |abgz
Digit zero|a0e0i0o0u|aaeeiioou
Wrap uc   |W57      |WBD
Wrap lc   |w57      |wbd
