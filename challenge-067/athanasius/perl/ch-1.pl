#!perl

################################################################################
=comment

Perl Weekly Challenge 067
=========================

Task #1
-------
*Number Combinations*

*Submitted by:* Mohammad S Anwar

You are given two integers $m and $n. Write a script [to] print all possible
combinations of $n numbers from the list 1 2 3 … $m.

Every combination should be sorted i.e. [2,3] is valid combination but [3,2] is
not.

*Example:*

Input: $m = 5, $n = 2

Output: [ [1,2], [1,3], [1,4], [1,5], [2,3], [2,4], [2,5], [3,4], [3,5], [4,5] ]

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Algorithm::Loops qw( NestedLoops );
use Const::Fast;
use Regexp::Common   qw( number );

const my $USAGE =>
"Usage:
  perl $0 <m> <n>

    <m>    Integer > 0: maximum of numbers to select
    <n>    Integer > 0: size of each n-combination\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    print "Challenge 067, Task #1: Number Combinations (Perl)\n\n";

    my ($m, $n) = parse_command_line();
    my  @combs;
 
    NestedLoops
    (
        [
            [ 1 .. $m ],                                # Outer loop
            (sub { [ $_ + 1 .. $m ] }) x ($n - 1),      # Inner loops
        ],

        sub                                             # Record one combination
        {
            push @combs, sprintf '[%s]', join ',', @_;
        },
    );

    my $count = scalar @combs;

    printf "There %s %d unique %d-combination%s of the integers 1 to %d:\n[ " .
           "%s ]\n", $count == 1 ? 'is' : 'are', $count, $n,
                     $count == 1 ? ''   : 's',   $m,     join ', ', @combs;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    scalar @ARGV == 2                        or die $USAGE;

    my ($m, $n) = @ARGV;

    $m =~ / \A $RE{num}{int} \z /x && $m > 0 or die $USAGE;
    $n =~ / \A $RE{num}{int} \z /x && $n > 0 or die $USAGE;

    $n <= $m or warn "Note: No combinations are possible, because n > m\n";

    return ($m, $n);
}

################################################################################
