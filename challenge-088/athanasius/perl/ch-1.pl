#!perl

###############################################################################
=comment

Perl Weekly Challenge 088
=========================

Task #1
-------
*Array of Product*

Submitted by: Mohammad S Anwar

You are given an array of positive integers @N.

Write a script to return an array @M where $M[i] is the product of all elements
of @N except the index $N[i].

Example 1:

 Input:
     @N = (5, 2, 1, 4, 3)
 Output:
     @M = (24, 60, 120, 30, 40)

     $M[0] = 2 x 1 x 4 x 3 = 24
     $M[1] = 5 x 1 x 4 x 3 = 60
     $M[2] = 5 x 2 x 4 x 3 = 120
     $M[3] = 5 x 2 x 1 x 3 = 30
     $M[4] = 5 x 2 x 1 x 4 = 40

Example 2:

 Input:
     @N = (2, 1, 4, 3)
 Output:
     @M = (12, 24, 6, 8)

     $M[0] = 1 x 4 x 3 = 12
     $M[1] = 2 x 4 x 3 = 24
     $M[2] = 2 x 1 x 3 = 6
     $M[3] = 2 x 1 x 4 = 8

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumption: "Positive" integers are those which are greater than zero.

Algorithm:  First find $product, the product of *all* the elements in @N; then,
            for each element in @N, divide $product by that element's value to
            get the desired sub-product for that index, and store it in @M.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use List::Util     qw( reduce );
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 [<N> ...]

    [<N> ...]    A non-empty, unsorted array of positive integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 088, Task #1: Array of Product (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @N = parse_command_line();

    print_array('Input',  \@N);

    my   $product = reduce { $a * $b } @N;                     # List reduction
    my   @M;
    push @M, $product / $N[$_] for 0 .. $#N;

    print_array('Output', \@M);
}

#------------------------------------------------------------------------------
sub print_array
#------------------------------------------------------------------------------
{
    my ($title, $array) = @_;

    print  "$title:\n";

    printf "    (%s)\n", join ', ', @$array;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my @N = @ARGV;

    scalar @N > 0           or error( 'The input array is empty' );

    for (@N)
    {
        /\A$RE{num}{int}\z/ or error( qq["$_" is not an integer] );
        $_ > 0              or error( qq["$_" is not positive]   );
    }

    return @N;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
