#!perl

################################################################################
=comment

Perl Weekly Challenge 053
=========================

Task #1
*Rotate Matrix*

Write a script to rotate the followin[g] matrix by given *90/180/270 degrees*
clockwise.

  [ 1, 2, 3 ]
  [ 4, 5, 6 ]
  [ 7, 8, 9 ]

For example, if you rotate by *90 degrees* then expected result should be like
below

  [ 7, 4, 1 ]
  [ 8, 5, 2 ]
  [ 9, 6, 3 ]

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use utf8;
use Const::Fast;

const my @MATRIX =>
         (
             [ 1, 2, 3 ],
             [ 4, 5, 6 ],
             [ 7, 8, 9 ],
         );

const my %ROTATIONS =>
         (
              90 => [
                        [ [2, 0], [1, 0], [0, 0] ],
                        [ [2, 1], [1, 1], [0, 1] ],
                        [ [2, 2], [1, 2], [0, 2] ],
                    ],
             180 => [
                        [ [2, 2], [2, 1], [2, 0] ],
                        [ [1, 2], [1, 1], [1, 0] ],
                        [ [0, 2], [0, 1], [0, 0] ],
                    ],
             270 => [
                        [ [0, 2], [1, 2], [2, 2] ],
                        [ [0, 1], [1, 1], [2, 1] ],
                        [ [0, 0], [1, 0], [2, 0] ],
                    ],
         );

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
    printf "Challenge 053, Task #1: Rotate Matrix (Perl)\n\n%s\n",
            format_matrix('Original matrix', \@MATRIX);

    my $rotation;

    for my $degrees (sort { $a <=> $b } keys %ROTATIONS)
    {
        $rotation = rotate($degrees, \@MATRIX);

        print format_matrix("Rotated $degrees°", $rotation), "\n";
    }

    # 270° rotated a further 90° --> 360° = 0° (the original matrix)

    print format_matrix('Rotated 360°', rotate(90, $rotation));
}

#-------------------------------------------------------------------------------
sub format_matrix
#-------------------------------------------------------------------------------
{
    my ($title, $matrix) = @_;

    my  $string  = sprintf  "%s:\n", $title;
        $string .= sprintf "[%s]\n", join( ', ', $matrix->[$_]->@* ) for 0 .. 2;

    return $string;
}

#-------------------------------------------------------------------------------
sub rotate
#-------------------------------------------------------------------------------
{
    my ($degrees, $old_matrix) = @_;

    exists $ROTATIONS{ $degrees }
        or die "ERROR: Rotation of $degrees° is not supported\n";

    my @new_matrix;

    for my $r_new (0 .. 2)          # Rows
    {
        for my $c_new (0 .. 2)      # Columns
        {
            my ($r_old, $c_old) = $ROTATIONS{ $degrees }->[$r_new][$c_new]->@*;

            $new_matrix[$r_new]->[$c_new] =  $old_matrix->[$r_old][$c_old];
        }
    }

    return \@new_matrix;
}

################################################################################
