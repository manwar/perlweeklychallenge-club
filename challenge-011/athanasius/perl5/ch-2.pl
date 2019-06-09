#!perl

################################################################################
=comment

Perl Weekly Challenge 011
=========================

Challenge #2
------------

Write a script to create an Indentity Matrix for the given size. For example, if
the size is 4, then create Identity Matrix 4x4. For more information about
*Indentity Matrix*, please read the
[ https://en.wikipedia.org/wiki/Identity_matrix |wiki] page.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 Perlmonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Scalar::Util::Numeric qw( isint );

const my $DEFAULT_SIZE =>  4;
const my $MAX_SIZE     => 39;   # Adjust for the target console

$| = 1;

MAIN:
{
    my $size   = $ARGV[0] // $DEFAULT_SIZE;
    my $matrix = identity_matrix($size);

    print "\nIdentity Matrix of size $size:\n";
    print_matrix($matrix);
}

sub identity_matrix
{
    my ($size) = @_;

    die "Invalid matrix size $size, stopped"
         unless isint($size) && $size > 0;

    die "Matrix size $size is too wide to be properly displayed, stopped"
         if $size > $MAX_SIZE;

    my $matrix;

    for my $i (0 .. $size - 1)
    {
        $matrix->[$i][$_] = ($i == $_) ? 1 : 0 for 0 .. $size - 1;
    }

    return $matrix;
}

sub print_matrix
{
    my ($matrix) = @_;
    my  $size    = scalar @$matrix;

    if ($size == 1)
    {
        print '[', $matrix->[0][0], "]\n";
    }
    else
    {
        print '|', join( ' ', $matrix->[$_]->@* ), "|\n" for 0 .. $size - 1;
    }
}

################################################################################
