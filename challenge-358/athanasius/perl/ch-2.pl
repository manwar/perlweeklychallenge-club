#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

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

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use bigrat;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my @ALPHABET => 'a' .. 'z';
const my $USAGE    => <<END;
Usage:
  perl $0 <str> <int>
  perl $0

    <str>    A string of alphabetic characters
    <int>    An integer
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 358, Task #2: Encrypted String (Perl)\n\n";
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
    elsif ($argc == 2)
    {
        my ($str, $int) = @ARGV;
        my  $re = join '|', @ALPHABET;

        $str =~ / ^ (?:$re)* $ /ix
                    or error( qq["$str" contains non-alphabetic characters] );

        $int =~ / ^ $RE{num}{real} $ /x
                    or error( qq["$int" is not a valid integer] );

        print qq[Input:  \$str = "$str", \$int = $int\n];

        my $encrypted = encrypt( $str, $int );

        print qq[Output: "$encrypted"\n];
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub encrypt
#-------------------------------------------------------------------------------
{
    my ($str, $int) = @_;
    my  $count = scalar   @ALPHABET;
    my  $plain = join '', @ALPHABET;
    my  $crypt = substr $plain . $plain, $int % $count, $count;
        $plain = uc( $plain ) . lc( $plain );
        $crypt = uc( $crypt ) . lc( $crypt );

    return eval "\$str =~ tr/$plain/$crypt/r";
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        while ($line =~ / \\ $ /x)
        {
            chop  $line;
            $line .= <DATA>;
            chomp $line;
        }

        my  ($test_name, $str, $int, $expected) = split / \| /x, $line;

        for ($test_name, $str, $int, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $encrypted = encrypt( $str, $int );

        is $encrypted, $expected, $test_name;
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
