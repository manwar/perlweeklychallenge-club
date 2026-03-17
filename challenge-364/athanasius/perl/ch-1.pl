#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

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

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string composed of digits and the hash character
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 364, Task #1: Decrypt String (Perl)\n\n";
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
        my $str =  $ARGV[0];
           $str =~ / ^ [0-9#]+ $ /x
                   or error( qq["$str" is not a valid input string] );

        print qq[Input:  \$str = "$str"\n];

        my $decrypted_str = decrypt_string( $str );

        print qq[Output: "$decrypted_str"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub decrypt_string
#-------------------------------------------------------------------------------
{
    my ($str) = @_;

    while ($str =~ m/ (\d) (\d) \# /x)
    {
        my $rep;
        my $val = $1 . $2;

        if (10 <= $val <= 26)
        {
            $rep = decrypt_value( $val );
        }
        else
        {
            $rep = decrypt_value( $1 ) . decrypt_value( $2 ) . '#';
        }

        $str =~ s/ $val \# /$rep/x;
    }

    return $str =~ tr/1-9/a-i/r;
}

#-------------------------------------------------------------------------------
sub decrypt_value
#-------------------------------------------------------------------------------
{
    my ($value) = @_;

    return chr( ord( 'a' ) + $value - 1 );
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

        my $decrypted_str = decrypt_string( $str );

        is $decrypted_str, $expected, $test_name;
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
Example 1   |10#11#12 |jkab
Example 2   |1326#    |acz
Example 3   |25#24#123|yxabc
Example 4   |20#5     |te
Example 5   |1910#26# |aijz
Assumption 1|0123     |0abc
Assumption 2|127#     |abg#
