#!perl

###############################################################################
=comment

Perl Weekly Challenge 145
=========================

TASK #1
-------
*Dot Product*

Submitted by: Mohammad S Anwar

You are given 2 arrays of same size, @a and @b.

Write a script to implement Dot Product.

Example:

 @a = (1, 2, 3);
 @b = (4, 5, 6);

 $dot_product = (1 * 4) + (2 * 5) + (3 * 6) => 4 + 10 + 18 => 32

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
Each of the two arrays must be entered on the command line as a string contain-
ing comma-separated real numbers. Each comma separator may, optionally, be
followed by whitespace.

Solution
--------
The dot product calculation is performed in this expression:

    sum0 pairmap { $a * $b } mesh $A, $B

which uses three subroutines from the core module List::Util.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use List::Util 1.56 qw( mesh pairmap sum0 );
use Regexp::Common  qw( number );

const my $USAGE =>
"Usage:
  perl $0 <a> <b>

    <a>    Comma-separated list of n real numbers
    <b>    Comma-separated list of n real numbers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 145, Task #1: Dot Product (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 2
            or error( "Expected 2 command line arguments, found $args" );

    my $A = parse_str( $ARGV[ 0 ] );
    my $B = parse_str( $ARGV[ 1 ] );

    scalar @$A == scalar @$B
            or error( 'The input lists have different sizes' );

    printf "Input:  \@a = (%s)\n", join ', ', @$A;
    printf "        \@b = (%s)\n", join ', ', @$B;

    printf "Output: %d\n", sum0 pairmap { $a * $b } mesh $A, $B;
}

#------------------------------------------------------------------------------
sub parse_str
#------------------------------------------------------------------------------
{
    my ($str) = @_;
    my  @list = split / \, \s* /x, $str;
    my  @nums;

    for my $s (@list)
    {
        $s =~ / ^ $RE{num}{real} $ /x
            or error( qq["$s" is not a valid number] );

        push @nums, $s;
    }

    return \@nums;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
