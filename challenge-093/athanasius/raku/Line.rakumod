use v6d;

###############################################################################
##
## Perl Weekly Challenge 093, Task #1: Max Points
##
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

my Real constant $EPSILON = 1.11e-16;  #  ~ 2^(-53) for 64-bit double precision

###############################################################################
unit class Line;
###############################################################################

has Bool $.is-horizontal = False;
has Bool $.is-vertical   = False;
has Real $.gradient;
has Real $.x-intercept;
has Real $.y-intercept;
has Pair @!points;

##=============================================================================
## Interface
##=============================================================================

#------------------------------------------------------------------------------
method collinear( Line:D $rhs --> Bool:D )
#------------------------------------------------------------------------------
{
    my Bool $collinear;

    if    $!is-horizontal
    {
        $collinear = $rhs.is-horizontal  &&
                     equals( $!y-intercept,  $rhs.y-intercept );
    }
    elsif $!is-vertical
    {
        $collinear = $rhs.is-vertical    &&
                     equals( $!x-intercept,  $rhs.x-intercept );
    }
    else
    {
        $collinear = !$rhs.is-horizontal && !$rhs.is-vertical   &&
                     equals( $!gradient,     $rhs.gradient    ) &&
                     equals( $!x-intercept,  $rhs.x-intercept );
    }

    return $collinear;
}

#------------------------------------------------------------------------------
method add-point( Pair:D $new-point )
#------------------------------------------------------------------------------
{
    my Bool $found = False;

    for @!points -> Pair $existing-point
    {
        if equals( $existing-point.key,   $new-point.key   ) &&
           equals( $existing-point.value, $new-point.value )
        {
            $found = True;
            last;
        }
    }

    @!points.push: $new-point unless $found;
}

#------------------------------------------------------------------------------
method count-points( --> UInt:D )
#------------------------------------------------------------------------------
{
    return @!points.elems;
}

=begin comment
#------------------------------------------------------------------------------
method show()                                                   # For debugging
#------------------------------------------------------------------------------
{
    "----\nLine:".put;
    "Gradient:    %s\n".printf: $!is-horizontal ?? '0 (horizontal)' !!
                                $!is-vertical   ?? 'Inf (vertical)' !!
                                $!gradient;
    "X-intercept: %s\n".printf: $!x-intercept if $!x-intercept.defined;
    "Y-intercept: %s\n".printf: $!y-intercept if $!y-intercept.defined;
    "Points: %s\n".\    printf: @!points.map( { sprintf "(%d,%d)", .kv } ).\
                                         join: ', ';
    '===='.put;
}
=end comment

#------------------------------------------------------------------------------
method show-points( --> Str:D )                            # For verbose output
#------------------------------------------------------------------------------
{
    return @!points.map( { "({ .key },{ .value })" } ).join: ', ';
}

##=============================================================================
## Implementation
##=============================================================================

#------------------------------------------------------------------------------
submethod BUILD( Real:D :$x1, Real:D :$y1, Real:D :$x2, Real:D :$y2 )
#------------------------------------------------------------------------------
{
    my Real $delta-x = $x2 - $x1;
    my Real $delta-y = $y2 - $y1;

    if    equals( $delta-x, 0 ) &&
          equals( $delta-y, 0 )
    {
        die "ERROR: Identical points ($x1, $y1), ($x2, $y2) do not define a " ~
            'line';
    }
    elsif equals( $delta-x, 0 )
    {
        $!is-vertical   = True;
        $!gradient      = ∞;
        $!x-intercept   = $x1;
    }
    elsif equals( $delta-y, 0 )
    {
        $!is-horizontal = True;
        $!gradient      = 0;
        $!y-intercept   = $y1;
    }
    else
    {
        $!gradient      = $delta-y / $delta-x;
        $!x-intercept   = $x1 - ($y1 / $!gradient);
        $!y-intercept   = $y1 - ($x1 * $!gradient);
    }

    @!points.push: $x1 => $y1, $x2 => $y2;
}

#------------------------------------------------------------------------------
sub equals( Real:D $lhs, Real:D $rhs --> Bool:D )
#------------------------------------------------------------------------------
{
    return abs($lhs - $rhs) < $EPSILON;
}

###############################################################################
