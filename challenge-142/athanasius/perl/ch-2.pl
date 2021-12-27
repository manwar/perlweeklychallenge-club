#!perl

###############################################################################
=comment

Perl Weekly Challenge 142
=========================

TASK #2
-------
*Sleep Sort*

Submitted by: Adam Russell

Another joke sort similar to JortSort suggested by champion Adam Russell.

You are given a list of numbers.

Write a script to implement Sleep Sort. For more information, please checkout
this [ https://iq.opengenus.org/sleep-sort |post].

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Configuration
-------------
Sleep Sort's performance is governed by the value assigned to the constant
$INTERVAL, and involves a tradeoff between speed and accuracy: the smaller the
value, the faster the sort will complete but the greater the chance that some
of the values will be out of their correct sort order.

Output
------
1. The sorted output is shown progressively, each value being displayed as it
   is found. (An alternative would be to store sorted values in a shared array
   and display them once the last thread has terminated.)
2. The input values are not restricted to integers: all non-negative real num-
   bers are accepted. This makes it more difficult to determine a practical
   value for $INTERVAL, as the minimum setting required to ensure accurate
   sorting depends on the smallest difference between non-identical numbers.
   For example, on my machine the integers 9, 2, 7, 0, 1, 5, 4, 8, 9, 0
   (minimum difference 1) are correctly sorted when $INVERVAL is set to 1, but
   correct sorting of the real numbers 9.2, 2, 7, 0, 1, 5, 4, 8.5, 9, 0
   (minimum difference 0.2) requires $INTERVAL to be set to at least 4.03.

=cut
#==============================================================================

use strict;
use warnings;
use threads;
use threads::shared;
use Const::Fast;
use Regexp::Common qw( number );

const my $INTERVAL => 1;
const my $USAGE    =>
"Usage:
  perl $0 [<numbers> ...]

    [<numbers> ...]    A list of non-negative real numbers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 142, Task #2: Sleep Sort (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @numbers = parse_command_line();

    printf "Input:  %s\n", join ', ', @numbers;
    print  'Output: ';

    my @threads;
    my $first :shared = 1;

    for my $n (@numbers)
    {
        push @threads,
             threads->create(
                                sub
                                {
                                    sleep $n * $INTERVAL if $n > 0;
                                    print ', ' unless $first;
                                    print $n;
                                    $first = 0;
                                }
                            );
    }

    $_->join for @threads;

    print "\n";
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    for (@ARGV)
    {
        / ^ $RE{num}{real} $ /x
                or error( qq["$_" is not a valid real number] );

        $_ >= 0 or error( qq["$_" is negative] );
    }

    return @ARGV;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
