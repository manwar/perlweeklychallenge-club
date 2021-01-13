#!perl

################################################################################
=comment

Perl Weekly Challenge 073
=========================

Task #1
-------
*Min Sliding Window*

Submitted by: Mohammad S Anwar

You are given an array of integers @A and sliding window size $S.

Write a script to create an array of min from each sliding window.

Example

Input: @A = (1, 5, 0, 2, 9, 3, 7, 6, 4, 8) and $S = 3
Output: (0, 0, 0, 2, 3, 3, 4, 4)

[(1 5 0) 2 9 3 7 6 4 8] = Min (0)
[1 (5 0 2) 9 3 7 6 4 8] = Min (0)
[1 5 (0 2 9) 3 7 6 4 8] = Min (0)
[1 5 0 (2 9 3) 7 6 4 8] = Min (2)
[1 5 0 2 (9 3 7) 6 4 8] = Min (3)
[1 5 0 2 9 (3 7 6) 4 8] = Min (3)
[1 5 0 2 9 3 (7 6 4) 8] = Min (4)
[1 5 0 2 9 3 7 (6 4 8)] = Min (4)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;                    # Exports const()
use Getopt::Long;                   # Exports GetOptions()
use List::Util     qw( min );
use PerlX::Window;                  # Exports window() and @window
use Regexp::Common qw( number );    # Exports %RE{num}

const my $USAGE =>
"Usage:
  perl $0 [-S <Natural>] [-A <Int> +]

    -S <Natural>    Sliding window size: 0 < S <= integers in A
    -A <Int> +      Sequence of one or more integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 073, Task #1: Min Sliding Window (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my ($S, @A) = parse_command_line();

    printf "Input: \@A = (%s) and \$S = %d\n", join(', ', @A), $S;

    my   @minima;
    push @minima, min(@window) while window(@A, $S);

    printf "Output: (%s)\n", join(', ', @minima);
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my ($S, @A);

    GetOptions
    (
        'S=i'     => \$S,
        'A=i{1,}' => \@A,
    )                       or die $USAGE;

    scalar @ARGV == 0       or die $USAGE;
    is_int($S) && $S > 0    or die $USAGE;
    is_int($_)              or die $USAGE for @A;
    $S <= scalar @A         or die $USAGE;

    return ($S, @A);
}

#-------------------------------------------------------------------------------
sub is_int
#-------------------------------------------------------------------------------
{
    my ($n) = @_;

    return defined($n) && $n =~ / \A $RE{num}{int} \z /x;
}

################################################################################
