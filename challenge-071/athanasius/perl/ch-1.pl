#!perl

################################################################################
=comment

Perl Weekly Challenge 071
=========================

Task #1
-------
*Peak Element*

*Submitted by:* Mohammad S Anwar

You are given positive integer _$N_ (>1).

Write a script to create an array of size _$N_ with random unique elements
between _1_ and _50_.

In the end it should print _peak elements_ in the array, if found.

    An array element is called peak if it is bigger than its neighbour[s].

*Example 1*

Array: [ 18, 45, 38, 25, 10, 7, 21, 6, 28, 48 ]
Peak:  [ 48, 45, 21 ]

*Example 2*

Array: [ 47, 11, 32, 8, 1, 9, 39, 14, 36, 23 ]
Peak:  [ 47, 32, 39, 36 ]

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use List::Util     qw( sample );
use Regexp::Common qw( number );

const my $MAX   => 50;
const my $USAGE =>
"Usage:
  raku ch-1.raku <N>

    <N>    Array size: N is an integer such that 1 < N <= $MAX\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 071, Task #1: Peak Element (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $N = parse_command_line();

    # List::Util::sample(): "Randomly select the given number of elements from
    # the input list. Any given position in the input list will be selected at
    # most once."

    my @array = sample $N, 1 .. $MAX;
    my $peaks = find_peaks(\@array);

    print 'Array: [ ', join(', ', @array ), " ]\n",
          'Peak:  [ ', join(', ', @$peaks), " ]\n";
}

#-------------------------------------------------------------------------------
sub find_peaks
#-------------------------------------------------------------------------------
{
    my  ($array) = @_;
    my   @peaks;
    push @peaks, $array->[0] if $array->[0] > $array->[1];      # First element

    for my $i (1 .. $#$array - 1)                        # Intermediate elements
    {
        push @peaks, $array->[$i] if $array->[$i] > $array->[$i - 1] &&
                                     $array->[$i] > $array->[$i + 1];
    }

    push @peaks, $array->[-1] if $array->[-1] > $array->[-2];   # Final element

    return \@peaks;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    scalar @ARGV == 1            or die $USAGE;

    my $N =  $ARGV[0];
       $N =~ /\A$RE{num}{int}\z/ or die $USAGE;
       $N >  1 && $N <= $MAX     or die $USAGE;

    return $N;
}

################################################################################
