#!perl

###############################################################################
=comment

Perl Weekly Challenge 191
=========================

TASK #1
-------
*Twice Largest*

Submitted by: Mohammad S Anwar

You are given list of integers, @list.

Write a script to find out whether the largest item in the list is at least
twice as large as each of the other items.

Example 1

  Input: @list = (1,2,3,4)
  Output: -1

  The largest in the given list is 4. However 4 is not greater than twice of
  every remaining elements.
  1 x 2 < 4
  2 x 2 > 4
  2 x 3 > 4

Example 2

  Input: @list = (1,2,0,5)
  Output: 1

  The largest in the given list is 5. Also 5 is greater than twice of every
  remaining elements.
  1 x 2 < 5
  2 x 2 < 5
  0 x 2 < 5

Example 3

  Input: @list = (2,6,3,1)
  Output: 1

  The largest in the given list is 6. Also 6 is greater than twice of every
  remaining elements.
  2 x 2 < 6
  3 x 2 < 6
  1 x 2 < 6

Example 4

  Input: @list = (4,5,2,3)
  Output: -1

  The largest in the given list is 5. Also 5 is not greater than twice of every
  remaining elements.
  4 x 2 > 5
  2 x 2 < 5
  3 x 2 > 5

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $TEST_FIELDS => 3;
const my $USAGE       =>
"Usage:
  perl $0 [<list> ...]
  perl $0

    [<list> ...]    A list of two or more integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 191, Task #1: Twice Largest (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        run_tests();
    }
    elsif ($args == 1)
    {
        error( 'Expected 0 or 2+ command-line arguments, found 1' );
    }
    else
    {
        my $list = parse_command_line();

        printf "Input:  \@list = (%s)\n", join ',', @$list;
        printf "Output: %d\n", twice_largest( $list );
    }
}

#------------------------------------------------------------------------------
sub twice_largest
#------------------------------------------------------------------------------
{
    my ($list)   = @_;
    my  @ordered = sort { $b <=> $a } @$list;         # Sort numeric descending
    my  $largest = $ordered[ 0 ];
    my  $next    = $ordered[ 1 ];

    return $largest >= (2 * $next) ? 1 : -1;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $list = [ @ARGV ];

    for my $elem (@$list)
    {
        $elem =~ / ^ $RE{num}{int} $ /x
            or error( qq[List element "$elem" is not a valid integer] );
    }

    return $list;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $in, $expected) =
            split / , \s* /x, $line, $TEST_FIELDS;

        my @list = split / \s+ /x, $in;

        is twice_largest( \@list ), $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1, 1 2 3 4, -1
Example 2, 1 2 0 5,  1
Example 3, 2 6 3 1,  1
Example 4, 4 5 2 3, -1
