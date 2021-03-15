use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 096, Task #2: Edit Distance

Matrix class for use in implementing the Wagner–Fischer algorithm for finding
the Levenshtein distance between two strings.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
unit class Matrix;
#==============================================================================

#------------------------------------------------------------------------------
# Matrix attributes
#------------------------------------------------------------------------------

has UInt       $.height;
has UInt       $.width;
has Array[Str] @!matrix;

#------------------------------------------------------------------------------
submethod BUILD( Str:D :$S1, Str:D :$S2 )
#------------------------------------------------------------------------------
{
    $!width  = $S1.chars + 1;
    $!height = $S2.chars + 1;

    for 0 .. $!height -> UInt $row
    {
        @!matrix[$row    ] = Array[Str].new;
        @!matrix[$row; $_] = Nil for 0 .. $!width;
    }

    my Str $word2 = "#$S2";
    my $i = 0;

    for 1 .. $!height -> UInt $row
    {
        @!matrix[$row; 0] = $word2.substr: $i, 1;
        @!matrix[$row; 1] = "$i";
        ++$i;
    }

    my Str $word1 = "#$S1";

    $i = 0;

    for 1 .. $!width -> UInt $col
    {
        @!matrix[0; $col] = $word1.substr: $i, 1;
        @!matrix[1; $col] = "$i";
        ++$i;
    }
}

#------------------------------------------------------------------------------
method element( UInt:D $row, UInt:D $col, UInt $value? --> UInt:D )  # Accessor
#------------------------------------------------------------------------------
{
    if $value.defined
    {
        @!matrix[$row + 1; $col + 1] = "$value";            # Set
    }

    return @!matrix[$row + 1; $col + 1].UInt;               # Get
}

#------------------------------------------------------------------------------
method display
#------------------------------------------------------------------------------
{
    # Pre-compute the maximum widths of individual columns

    my UInt @widths = 1;

    for 1 .. $!width -> UInt $col
    {
        my UInt $max = 0;

        for 1 .. $!height -> UInt $row
        {
            my Str  $current = @!matrix[$row; $col];
            my UInt $cur-len = $current.chars;
                    $max     = $cur-len if $cur-len > $max;
        }

        @widths[ $col ] = $max;
    }

    # Draw a vertical separator

    my Str $line  = '+';
           $line ~= '-%s-+'.sprintf: '-'  x @widths[ $_ ] for 0 .. $!width;
           $line ~= "\n";

    # Draw the matrix

    my Str $display = $line;

    for 0 .. $!height -> UInt $row
    {
        $display ~= '|';
        $display ~= ' %*s |'.sprintf: @widths[ $_ ], @!matrix[$row; $_] // ' '
                        for 0 .. $!width;
        $display ~= "\n" ~ $line;
    }

    return $display;
}

##############################################################################
