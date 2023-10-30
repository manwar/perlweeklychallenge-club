#!perl

################################################################################
=comment

Perl Weekly Challenge 236
=========================

TASK #1
-------
*Exact Change*

Submitted by: Mohammad S Anwar

You are asked to sell juice each costs $5. You are given an array of bills. You
can only sell ONE juice to each customer but make sure you return exact change
back. You only have $5, $10 and $20 notes. You do not have any change in hand at
first.

Write a script to find out if it is possible to sell to each customers with
correct change.

Example 1

  Input: @bills = (5, 5, 5, 10, 20)
  Output: true

  From the first 3 customers, we collect three $5 bills in order.
  From the fourth customer, we collect a $10 bill and give back a $5.
  From the fifth customer, we give a $10 bill and a $5 bill.
  Since all customers got correct change, we output true.

Example 2

  Input: @bills = (5, 5, 10, 10, 20)
  Output: false

  From the first two customers in order, we collect two $5 bills.
  For the next two customers in order, we collect a $10 bill and give back a $5
  bill.
  For the last customer, we can not give the change of $15 back because we only
  have two $10 bills.
  Since not every customer received the correct change, the answer is false.

Example 3

  Input: @bills = (5, 5, 5, 20)
  Output: true

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

=cut
#===============================================================================

use v5.32.1;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [<bills> ...]
  perl $0

    [<bills> ...]    A list of bills: \$5, \$10, and \$20 only\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 236, Task #1: Exact Change (Perl)\n\n";
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
        my $bills = parse_command_line();

        printf "Input:  \@bills = (%s)\n", join ', ', @$bills;

        my $can_give_change = give_change( $bills );

        printf "Output: %s\n", $can_give_change ? 'True' : 'False';
    }
}

#-------------------------------------------------------------------------------
sub give_change
#-------------------------------------------------------------------------------
{
    my ($bills)       = @_;
    my  %cash_in_hand = (5 => 0, 10 => 0, 20 => 0);

    for my $bill (@$bills)
    {
        ++$cash_in_hand{ $bill };

        if    ($bill == 10)       #  $5 change due
        {
            return 0 if $cash_in_hand{ 5 } == 0;

            --$cash_in_hand{ 5 };
        }
        elsif ($bill == 20)       # $15 change due
        {
            if    ($cash_in_hand{ 10 } >= 1 &&
                   $cash_in_hand{  5 } >= 1)
            {
                 --$cash_in_hand{ 10 };
                 --$cash_in_hand{  5 };
            }
            elsif ($cash_in_hand{  5 } >= 3)
            {
                   $cash_in_hand{  5 } -= 3;
            }
            else
            {
                return 0;
            }
        }
    }

    return 1;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    for (@ARGV)
    {
        / ^ $RE{num}{int} $ /x
            or error( qq["$_" is not a valid integer] );

        $_ == 5 || $_ == 10 || $_ == 20
            or error( qq["$_" is not a valid note denomination]);
    }

    return \@ARGV;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $bills_str, $expected) = split / \| /x, $line;

        for ($test_name, $bills_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @bills           = split / \s+ /x, $bills_str;
        my $can_give_change = give_change( \@bills ) ? 'True' : 'False';

        is $can_give_change, $expected, $test_name;
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
Example 1|5 5  5 10 20|True
Example 2|5 5 10 10 20|False
Example 3|5 5  5 20   |True
