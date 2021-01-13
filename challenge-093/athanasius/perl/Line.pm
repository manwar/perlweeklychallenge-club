#!perl

###############################################################################
##
## Perl Weekly Challenge 093, Task #1: Max Points
##
###############################################################################

package Line;

use strict;
use warnings;

use constant EPSILON => 1.11e-16;      #  ~ 2^(-53) for 64-bit double precision

##=============================================================================
## Interface
##=============================================================================

#------------------------------------------------------------------------------
sub new
#------------------------------------------------------------------------------
{
    my ($class, $x1, $y1, $x2, $y2) = @_;
    my  $delta_x       = $x2 - $x1;
    my  $delta_y       = $y2 - $y1;
    my  $is_horizontal = 0;
    my  $is_vertical   = 0;
    my  $gradient;
    my  $x_intercept;
    my  $y_intercept;

    if    (equals( $delta_x, 0 ) &&
           equals( $delta_y, 0 ))
    {
        die sprintf "ERROR: Identical points (%d, %d), (%d, %d) do not " .
                    "define a line\n", $x1, $y1, $x2, $y2;
    }
    elsif (equals( $delta_x, 0 ))
    {
        $is_vertical   = 1;
        $x_intercept   = $x1;
    }
    elsif (equals( $delta_y, 0 ))
    {
        $is_horizontal = 1;
        $gradient      = 0;
        $y_intercept   = $y1;
    }
    else
    {
        $gradient      = $delta_y / $delta_x;
        $x_intercept   = $x1 - ($y1 / $gradient);
        $y_intercept   = $y1 - ($x1 * $gradient);
    }

    my %self = (is_horizontal => $is_horizontal,
                is_vertical   => $is_vertical,
                gradient      => $gradient,
                x_intercept   => $x_intercept,
                y_intercept   => $y_intercept,
                points        => [ [$x1, $y1], [$x2, $y2] ]);

    return bless \%self, $class;
}

#------------------------------------------------------------------------------
sub collinear
#------------------------------------------------------------------------------
{
    my ($self, $rhs) = @_;
    my  $collinear;

    if    ($self->{is_horizontal})
    {
        $collinear = $rhs->{is_horizontal}  &&
                     equals( $self->{y_intercept}, $rhs->{y_intercept} );
    }
    elsif ($self->{is_vertical})
    {
        $collinear = $rhs->{is_vertical}    &&
                     equals( $self->{x_intercept}, $rhs->{x_intercept} );
    }
    else
    {
        $collinear = !$rhs->{is_horizontal} &&    !$rhs->{is_vertical}   &&
                     equals( $self->{gradient},    $rhs->{gradient}    ) &&
                     equals( $self->{x_intercept}, $rhs->{x_intercept} );
    }

    return $collinear;
}

#------------------------------------------------------------------------------
sub add_point
#------------------------------------------------------------------------------
{
    my ($self, $new_point) = @_;
    my  $found = 0;

    for my $existing_point (@{ $self->{points} })
    {
        if (equals( $existing_point->[0], $new_point->[0] ) &&
            equals( $existing_point->[1], $new_point->[1] ))
        {
            $found = 1;
            last;
        }
    }

    push @{ $self->{points} }, $new_point unless $found;
}

#------------------------------------------------------------------------------
sub count_points
#------------------------------------------------------------------------------
{
    my ($self) = @_;

    return scalar @{ $self->{points} };
}

#------------------------------------------------------------------------------
sub show_points                                            # For verbose output
#------------------------------------------------------------------------------
{
    my ($self) = @_;

    return join ', ',
           map { '(' . $_->[0] . ',' . $_->[1] . ')' } @{ $self->{points} };
}

##=============================================================================
## Implementation
##=============================================================================

#------------------------------------------------------------------------------
sub equals
#------------------------------------------------------------------------------
{
    my ($lhs, $rhs) = @_;

    return abs($lhs - $rhs) < EPSILON;
}

###############################################################################
1;
###############################################################################
