#!perl

################################################################################
=comment

Perl Weekly Challenge 290
=========================

TASK #2
-------
*Luhn's Algorithm*

Submitted by: Andrezgz

You are given a string $str containing digits (and possibly other characters
which can be ignored). The last digit is the payload; consider it separately.
Counting from the right, double the value of the first, third, etc. of the
remaining digits.

For each value now greater than 9, sum its digits.

The correct check digit is that which, added to the sum of all values, would
bring the total mod 10 to zero.

Return true if and only if the payload is equal to the correct check digit.

It was originally posted on [https://www.reddit.com/r/coolguides/comments/
1faosv9/a_cool_guide_on_how_to_validate_credit_card/?rdt=51254|reddit].

Example 1

  Input: "17893729974"
  Output: true

  Payload is 4.

  Digits from the right:

  7 * 2 = 14, sum = 5
  9 = 9
  9 * 2 = 18, sum = 9
  2 = 2
  7 * 2 = 14, sum = 5
  3 = 3
  9 * 2 = 18, sum = 9
  8 = 8
  7 * 2 = 14, sum = 5
  1 = 1

  Sum of all values = 56, so 4 must be added to bring the total mod 10 to zero.
  The payload is indeed 4.

Example 2

  Input: "4137 8947 1175 5904"
  Output: true

Example 3

  Input: "4137 8974 1175 5904"
  Output: false

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string is entered on the command-line.
3. If the constant $VERBOSE is set to a true value, then an output of "false" is
   followed by the correct check digit.

Assumption
----------
The string "0" is valid because the sum of the empty set (of integers) is 0.

Reference
---------
"Luhn algorithm", _Wikipedia_, https://en.wikipedia.org/wiki/Luhn_algorithm

=cut
#===============================================================================

use v5.32;         # Enables strictures and warnings
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string
END

# Double the index, then, if the sum has 2 digits, add them together
# E.g.,  $DOUBLE_TO_DIGIT[ 7 ] is 5 because 2 * 7 = 14 and 1 + 4 = 5

const my @DOUBLE_TO_DIGIT => (0, 2, 4, 6, 8, 1, 3, 5, 7, 9);

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 290, Task #2: Luhn's Algorithm (Perl)\n\n";
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
        my $str = $ARGV[ 0 ];

        print qq[Input: "$str"\n];

        my ($valid, $check_sum) = validate( $str );

        printf "Output: %s\n", $valid ? 'true' : 'false';

        if ($VERBOSE && !$valid)
        {
            my $payload =  substr $str, -1, 1;
               $payload = 'missing' if $payload !~ / ^ $RE{num}{int} $ /x;

            print "\nThe current check digit is $payload\n";
            print   "The correct check digit is $check_sum\n";
        }
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub validate
#-------------------------------------------------------------------------------
{
    my ($str)   =  @_;
    my  @result = (0, 0);
    my  @chars  =  split //, $str;

    if (scalar @chars > 0)
    {
        my $payload = pop @chars;
        my $sum     = 0;
        my $double  = 1;

        for (my $i = $#chars; $i >= 0; --$i)
        {
            my $char = $chars[ $i ];

            if ($char =~ / ^ $RE{num}{int} $ /x)
            {
                $sum   +=  $double ? $DOUBLE_TO_DIGIT[ $char ] : $char;
                $double = !$double;
            }
        }

        my $check_digit = (10 - ($sum % 10)) % 10;
        my $is_valid    =  $payload =~ / ^ $RE{num}{int} $ /x &&
                           $payload == $check_digit;

        @result = ($is_valid, $check_digit);
    }

    return @result;
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

        my ($valid) = validate( $str );

        is  $valid ? 'true' : 'false', $expected, $test_name;
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
Example 1 |17893729974        |true
Example 2 |4137 8947 1175 5904|true
Example 3 |4137 8974 1175 5904|false
Example 1a|a1b7c8d9e3f7g2h9974|true
