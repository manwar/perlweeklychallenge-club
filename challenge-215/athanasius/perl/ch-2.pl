#!perl

################################################################################
=comment

Perl Weekly Challenge 215
=========================

TASK #2
-------
*Number Placement*

Submitted by: Mohammad S Anwar

You are given a list of numbers having just 0 and 1. You are also given place-
ment count (>=1).

Write a script to find out if it is possible to replace 0 with 1 in the given
list. The only condition is that you can only replace when there is no 1 on
either side. Print 1 if it is possible otherwise 0.

Example 1:

  Input: @numbers = (1,0,0,0,1), $count = 1
  Output: 1

  You are asked to replace only one 0 as given count is 1.
  We can easily replace middle 0 in the list i.e. (1,0,1,0,1).

Example 2:

  Input: @numbers = (1,0,0,0,1), $count = 2
  Output: 0

  You are asked to replace two 0's as given count is 2.
  It is impossible to replace two 0's.

Example 3:

  Input: @numbers = (1,0,0,0,0,0,0,0,1), $count = 3
  Output: 1

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
2. If $VERBOSE is set to a true value, an output of 1 is followed by a list
   containing the required replacements.

Assumption
----------
The task description says:

    "...replace 0 with 1 in the given list.... you can only replace when there
     is no 1 on either side."

I assume this condition (re-)applies *as each replacement is made*. For example,
in the list:

    (1,0,0,0,0,1)
     a b c d e f

the middle two zeros (c and d) both satisfy the condition at the outset; but
once a single replacement is made, e.g. replace c: (1,0,1,0,0,1), the condition
no longer holds for d, so no further replacement is possible.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 <numbers> <count>
  perl $0

    <numbers>    Non-empty string of 0s and 1s
    <count>      Placement count (>= 1)\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 215, Task #2: Number Placement (Perl)\n\n";
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
    elsif ($args == 2)
    {
        my ($numbers, $count) = parse_command_line();

        printf "Input:  \@numbers = (%s), \$count = %d\n",
            join( ',', @$numbers ), $count;

        my $new_list = make_replacements( $numbers, $count );

        printf "Output: %d\n", defined $new_list ? 1 : 0;

        if ($VERBOSE && defined $new_list)
        {
            printf "\nReplacement list:  (%s)\n", join ',', @$new_list;
        }
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $args" );
    }
}

#-------------------------------------------------------------------------------
sub make_replacements
#-------------------------------------------------------------------------------
{
    my ($numbers, $count) = @_;

    for my $i (0 .. $#$numbers)
    {
        if (($i == 0          || $numbers->[ $i - 1 ] == 0) &&
                                 $numbers->[ $i     ] == 0  &&
            ($i == $#$numbers || $numbers->[ $i + 1 ] == 0))
        {
            $numbers->[ $i ] = 1;

            return $numbers if --$count == 0;
        }
    }

    return;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my ($numbers, $count) = @ARGV;

    $numbers =~ / ^ [01]+ $ /x
        or error( qq[Invalid <numbers> argument "$numbers"] );

    my @numbers = split //, $numbers;

    $count =~ / ^ $RE{num}{int} $ /x && $count > 0
        or error( qq[Invalid <count> argument "$count"] );

    return (\@numbers, $count);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $numbers, $count, $expected) = split / \| /x, $line;

        s/ \s+ $ //x for $test_name, $numbers, $count;         # Trim whitespace

        my @numbers  = split //, $numbers;
        my $new_list = make_replacements( \@numbers, $count );
        my $got      = defined $new_list ? 1 : 0;

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
Example 1    |10001        |1|1
Example 2    |10001        |2|0
Example 3    |100000001    |3|1
Beginning    |0010000000010|4|1
Ending       |0100000000100|4|1
Start and end|001100       |2|1
One too many |0100000000100|5|0
