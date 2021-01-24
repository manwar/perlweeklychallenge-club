#!perl

###############################################################################
=comment

Perl Weekly Challenge 096, Task #2: Edit Distance

Matrix class for use in implementing the Wagner–Fischer algorithm for finding
the Levenshtein distance between two strings.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
package Matrix;
#==============================================================================

use strict;
use warnings;

#------------------------------------------------------------------------------
sub new                                                           # Constructor
#------------------------------------------------------------------------------
{
    my ($class, $word1, $word2) = @_;

    my  $cols = length( $word1 ) + 1;
    my  $rows = length( $word2 ) + 1;
    my  @matrix;

    for my $row (0 .. $rows)
    {
        $matrix[ $row ][ $_ ] = undef for 0 .. $cols;
    }

    $word2 = "#$word2";
    my $i  = 0;

    for my $row (1 .. $rows)
    {
        $matrix[ $row ][ 0 ] = substr $word2, $i, 1;
        $matrix[ $row ][ 1 ] = $i++;
    }

    $word1 = "#$word1";
    $i     = 0;

    for my $col (1 .. $cols)
    {
        $matrix[ 0 ][ $col ] = substr $word1, $i, 1;
        $matrix[ 1 ][ $col ] = $i++;
    }

    my %self = (
                   height =>  $rows,
                   width  =>  $cols,
                   matrix => \@matrix,
               );

    return bless \%self, $class;
}

#------------------------------------------------------------------------------
sub height                                              # Accessor: getter only
#------------------------------------------------------------------------------
{
    my ($self) = @_;

    return $self->{height};
}

#------------------------------------------------------------------------------
sub width                                               # Accessor: getter only
#------------------------------------------------------------------------------
{
    my ($self) = @_;

    return $self->{width};
}

#------------------------------------------------------------------------------
sub element                                       # Accessor: getter and setter
#------------------------------------------------------------------------------
{
    my ($self, $row, $col, $value) = @_;

    if (defined $value)
    {
        $self->{matrix}[ $row + 1 ][ $col + 1 ] = $value;       # Set
    }

    return $self->{matrix}[ $row + 1 ][ $col + 1 ];             # Get
}

#------------------------------------------------------------------------------
sub display
#------------------------------------------------------------------------------
{
    my ($self)  = @_;
    my  $height = $self->{height};
    my  $width  = $self->{width};

    # Pre-compute the maximum widths of individual columns

    my @widths = ( 1 );

    for my $col (1 .. $width)
    {
        my $max = 0;

        for my $row (1 .. $height)
        {
            my $current = $self->{matrix}[ $row ][ $col ];
            my $cur_len = length $current;
               $max     = $cur_len if $cur_len > $max;
        }

        $widths[$col] = $max;
    }

    # Draw a vertical separator

    my $line  = '+';
       $line .=  sprintf '-%s-+', '-'  x $widths[ $_ ] for 0 .. $width;
       $line .= "\n";

    # Draw the matrix

    my $display = $line;

    for my $row (0 .. $height)
    {
        $display .= '|';
        $display .=  sprintf ' %*s |', $widths[ $_ ],
                                       $self->{matrix}[ $row ][ $_ ] // ' '
                        for 0 .. $width;
        $display .= "\n" . $line;
    }

    return $display;
}

###############################################################################
1;
###############################################################################
