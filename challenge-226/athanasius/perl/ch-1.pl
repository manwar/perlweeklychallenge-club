#!perl

################################################################################
=comment

Perl Weekly Challenge 226
=========================

TASK #1
-------
*Shuffle String*

Submitted by: Mohammad S Anwar

You are given a string and an array of indices of same length as string.

Write a script to return the string after re-arranging the indices in the
correct order.

Example 1

  Input: $string = 'lacelengh', @indices = (3,2,0,5,4,8,6,7,1)
  Output: 'challenge'

Example 2

  Input: $string = 'rulepark', @indices = (4,7,3,1,0,5,2,6)
  Output: 'perlraku'

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Assumption
----------
The indices must be unique and valid, i.e., there must be exactly one index for
each letter in $string.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 <string> [<indices> ...]
  perl $0

    <string>           A non-empty string
    [<indices> ...]    A list of indices, one for each letter in the string\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 226, Task #1: Shuffle String (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my ($string, $indices) = parse_command_line();

        printf "Input:  \$string = '%s', \@indices = (%s)\n",
                $string, join ',', @$indices;

        my $new_str = shuffle( $string, $indices );

        print "Output: '$new_str'\n";
    }
}

#-------------------------------------------------------------------------------
sub shuffle
#-------------------------------------------------------------------------------
{
    my ($string, $indices) = @_;

    my  @orig = split '', $string; 
    my  @new;

    for my $i (0 .. $#$indices)
    {
        $new[ $indices->[ $i ] ] = $orig[ $i ];
    }

    return join '', @new;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $string  = shift @ARGV;
    my $length  = length $string;

    $length > 0                or  error( 'Empty string' );

    my @indices = @ARGV;

    for (@indices)
    {
        / ^ $RE{num}{int} $ /x or  error( qq["$_" is not a valid integer] );
        $_ >= 0                or  error( qq["$_" is negative] );
    }

    scalar @indices < $length  and error( 'Not enough indices' );
    scalar @indices > $length  and error( 'Too many indices' );

    my @actual = sort { $a <=> $b } @indices;

    for my $i (0 .. $length - 1)
    {
        $actual[ $i ] == $i    or  error( 'The indices are invalid' );
    }

    return ($string, \@indices);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $string, $idx_str, $expected) = split / \| /x, $line;

        for ($test_name, $string, $idx_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @indices = split / \s+ /x, $idx_str;
        my $new_str = shuffle( $string, \@indices );

        is $new_str, $expected, $test_name;
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
Example 1  |lacelengh    | 3 2 0 5 4  8 6 7 1         |challenge
Example 2  |rulepark     | 4 7 3 1 0  5 2 6           |perlraku
Wikipedia 1|elevenplustwo|12 3 5 4 2 11 6 7 8 9 0 1 10|twelveplusone
Wikipedia 2|radiumcame   | 7 1 2 8 6  0 5 3 4 9       |madamcurie
