#!perl

###############################################################################
=comment

Perl Weekly Challenge 159
=========================

TASK #1
-------
*Farey Sequence*

Submitted by: Mohammad S Anwar

You are given a positive number, $n.

Write a script to compute Farey Sequence of the order $n.

Example 1:

  Input: $n = 5
  Output: 0/1, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1.

Example 2:

  Input: $n = 7
  Output: 0/1, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 2/5, 3/7, 1/2, 4/7, 3/5, 2/3, 5/7,
          3/4, 4/5, 5/6, 6/7, 1/1.

Example 3:

  Input: $n = 4
  Output: 0/1, 1/4, 1/3, 1/2, 2/3, 3/4, 1/1.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumption
----------
The sequence is restricted to terms in the range 0 to 1 inclusive.

Algorithm
---------
1. The 2 initial terms are always 0/1 and 1/n.
2. Let p/q be the term immediately following a/b, c/d [1: "Next term"]; then
     p = ⌊ (n + b) / d ⌋ × c - a
     q = ⌊ (n + b) / d ⌋ × d - b.
3. The sequence ends when p/q = 1/1.

Reference
---------
[1] "Farey sequence", Wikipedia, https://en.wikipedia.org/wiki/Farey_sequence

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 <n>

    <n>    The order of the required Farey sequence\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 159, Task #1: Farey Sequence (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $n = parse_command_line();

    my ($a, $b, $c, $d) = (0, 1, 1, $n);

    print "Input:  \$n = $n\nOutput: $a/$b, $c/$d";

    until ($c == $d == 1)
    {
        my $t = int( ($n + $b) / $d );
        my $p = $t * $c - $a;
        my $q = $t * $d - $b;

        print ", $p/$q";

        ($a, $b, $c, $d) = ($c, $d, $p, $q);
    }

    print "\n";
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $n = $ARGV[ 0 ];

       $n =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$n" is not a valid integer] );

       $n > 0     or error( 'n must be greater than 0' );

    return $n;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
