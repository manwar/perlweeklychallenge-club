use v6;

################################################################################
=begin comment

Perl Weekly Challenge 053
=========================

Task #1
*Rotate Matrix*

Write a script to rotate the followin(g) matrix by given *90/180/270 degrees*
clockwise.

  ( 1, 2, 3 )
  ( 4, 5, 6 )
  ( 7, 8, 9 )

For example, if you rotate by *90 degrees* then expected result should be like
below

  ( 7, 4, 1 )
  ( 8, 5, 2 )
  ( 9, 6, 3 )

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

my constant @MATRIX    = (1, 2, 3), (4, 5, 6), (7, 8, 9);
my constant %ROTATIONS =  90 => (
                                    ( (2, 0), (1, 0), (0, 0) ),
                                    ( (2, 1), (1, 1), (0, 1) ),
                                    ( (2, 2), (1, 2), (0, 2) ),
                                ),
                         180 => (
                                    ( (2, 2), (2, 1), (2, 0) ),
                                    ( (1, 2), (1, 1), (1, 0) ),
                                    ( (0, 2), (0, 1), (0, 0) ),
                                ),
                         270 => (
                                    ( (0, 2), (1, 2), (2, 2) ),
                                    ( (0, 1), (1, 1), (2, 1) ),
                                    ( (0, 0), (1, 0), (2, 0) ),
                                );

#-------------------------------------------------------------------------------
BEGIN ''.put;
#-------------------------------------------------------------------------------

#===============================================================================
sub MAIN()
#===============================================================================
{
    "Challenge 053, Task #1: Rotate Matrix (Raku)\n".put;
    format-matrix('Original matrix', @MATRIX).put;

    my @rotation;

    for %ROTATIONS.keys.sort: { $^a <=> $^b } -> Str $degrees
    {
        @rotation = rotate($degrees, @MATRIX);

        format-matrix("Rotated $degrees degrees", @rotation).put;
    }

    # 270° rotated a further 90° --> 360° = 0° (the original matrix)

    format-matrix('Rotated 360 degrees', rotate('90', @rotation)).print;
}

#-------------------------------------------------------------------------------
sub format-matrix(Str:D $title, @matrix --> Str)
#-------------------------------------------------------------------------------
{
    my Str $string  =  "%s:\n".sprintf: $title;
           $string ~= "(%s)\n".sprintf: @matrix[$_].join: ', ' for 0 .. 2;

    return $string;
}

#-------------------------------------------------------------------------------
sub rotate(Str:D $degrees, @old-matrix --> Array)
#-------------------------------------------------------------------------------
{
    %ROTATIONS{ $degrees }:exists
        or die "ERROR: Rotation of $degrees degrees is not supported\n";

    my @new-matrix;

    for 0 .. 2 -> UInt $row-new
    {
        for 0 .. 2 -> UInt $col-new
        {
            my UInt @old = %ROTATIONS{ $degrees }[$row-new][$col-new];

            @new-matrix[$row-new][$col-new] = @old-matrix[ @old[0] ][ @old[1] ];
        }
    }

    return @new-matrix;
}

################################################################################
