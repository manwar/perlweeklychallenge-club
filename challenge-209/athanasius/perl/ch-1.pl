#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to a true value, the required output (1 or 0) is followed
   by the decoded text.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 <bits>
  perl $0

    <bits>    A string of binary bits ending in 0\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 209, Task #1: Special Bit Characters (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        run_tests();
    }
    elsif ($args == 1)
    {
        my $bits = parse_command_line( $ARGV[ 0 ] );

        printf "Input:  \@bits = (%s)\n", join ', ', @$bits;

        my ($text, $output) = decode( $bits );

        print "Output: $output\n";
        print "\nDecoded string: $text\n" if $VERBOSE;
    }
    else
    {
        error( "Expected 1 or 0 command line arguments, found $args");
    }
}

#-------------------------------------------------------------------------------
sub decode
#-------------------------------------------------------------------------------
{
    my ($bits) = @_;
    my  $text;

    while (@$bits)
    {
        my $bit0 = shift @$bits;

        if ($bit0 == 0)
        {
            $text .= 'a';
        }
        else
        {
            my $bit1 = shift @$bits;

            $text .= $bit1 == 0 ? 'b' : 'c';
        }
    }

    return ($text, $text =~ / a $ /x ? 1 : 0);
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my ($bits) = @_;

    $bits =~ / ^ [01]* 0 $ /x
        or error( 'Invalid input string' );

    my @bits = split //, $bits;

    return \@bits;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $input, $expected) = split / \| /x, $line;

        $test_name =~ s/ \s+ $ //x;
        $input     =~ s/ \s+ $ //x;

        my  @bits        = split //, $input;
        my ($text, $out) = decode( \@bits );
        my  $got         = "$text=$out";

        is $got, $expected, $test_name;
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
Example 1|100           |ba=1
Example 2|1110          |cb=0
Longer   |11101001101000|cbbacabaa=1
