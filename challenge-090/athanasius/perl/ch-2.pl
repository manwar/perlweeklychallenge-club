#!perl

###############################################################################
=comment

Perl Weekly Challenge 090
=========================

Task #2
-------
*Ethiopian Multiplication*

Submitted by: Mohammad S Anwar

You are given two positive numbers $A and $B.

Write a script to demonstrate [https://threesixty360.wordpress.com/2009/06/09/
ethiopian-multiplication/|Ethiopian Multiplication] using the given numbers.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 <A> <B>

    <A>    A positive integer (the multiplier)
    <B>    A positive integer (the multiplicand)\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 090, Task #2: Ethiopian Multiplication (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($A, $B)  = parse_command_line();
    my  $lhs     = $A;
    my  $rhs     = $B;
    my  $l_width = length $lhs;
    my  $r_width = length $rhs * (2 ** int(log($lhs) / log(2)));
    my  @terms;

    while ($lhs >= 1)
    {
        my $action = 'ignore';

        if ($lhs % 2 == 1)
        {
            $action = 'add';
            push @terms, $rhs;
        }

        printf "%*d & %*d --> %s\n", $l_width, $lhs, $r_width, $rhs, $action;

        $lhs  = int($lhs / 2);
        $rhs *= 2;
    }

    my $sum  = 0;
       $sum += $_ for @terms;

    printf "\n%d * %d = %s\n", $A, $B, join ' + ', @terms;
    printf "%s = %d\n", ' ' x ($l_width + 3 + length $B), $sum;

    my $product = $A * $B;

    $sum == $product or die "ERROR: product is $sum, should be $product\n";
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;

    $args == 0 and error( 'No command-line arguments found' );
    $args == 2 or  error( 'Incorrect number of command-line arguments' );

    my $A = $ARGV[0];
    my $B = $ARGV[1];

    for ($A, $B)
    {
        / \A $RE{num}{int} \z /x or error( qq["$_" is not an integer] );
        $_ > 0                   or error( qq["$_" is not positive] );
    }

    return ($A, $B);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
