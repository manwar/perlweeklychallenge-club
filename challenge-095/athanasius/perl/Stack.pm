#!perl

###############################################################################
=comment

Perl Weekly Challenge 095, Task #2: Demo Stack

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
package Stack;
#==============================================================================

use strict;
use warnings;
use Regexp::Common qw( number );

#------------------------------------------------------------------------------
sub new
#------------------------------------------------------------------------------
{
    my ($class, $throw) = @_;

    my  %self = ( throw => $throw // 1,
                  top   => -1,
                  items => [] );

    return bless \%self, $class;
}

#------------------------------------------------------------------------------
sub push
#------------------------------------------------------------------------------
{
    my ($self, $item) = @_;

    $item =~ / ^ $RE{num}{real} $ /x or die qq[ERROR: "$item" is not a number];

    push @{ $self->{items} }, $item;

    ++$self->{top};
}

#------------------------------------------------------------------------------
sub pop
#------------------------------------------------------------------------------
{
    my ($self) = @_;
    my  $item;

    if ($self->{top} >= 0)
    {
        $item = pop @{ $self->{items} };

        --$self->{top};
    }
    elsif ($self->{throw})
    {
        die "ERROR: Cannot pop() an empty stack\n";
    }

    return $item;
}

#------------------------------------------------------------------------------
sub top
#------------------------------------------------------------------------------
{
    my ($self) = @_;
    my  $item;

    if ($self->{top} >= 0)
    {
        $item = $self->{items}->[ $self->{top} ];
    }
    elsif ($self->{throw})
    {
        die "ERROR: There is no top() on an empty stack\n";
    }

    return $item;
}

#------------------------------------------------------------------------------
sub min
#------------------------------------------------------------------------------
{
    my ($self) = @_;
    my  $min;

    if ($self->{top} >= 0)
    {
        $min = $self->{items}->[ 0 ];

        for my $i (1 .. scalar @{ $self->{items} } - 1)
        {
            my $new_min = $self->{items}->[ $i ];

            $min = $new_min if $new_min < $min;
        }
    }
    elsif ($self->{throw})
    {
        die "ERROR: There is no min() for an empty stack\n";
    }

    return $min;
}

#------------------------------------------------------------------------------
sub display
#------------------------------------------------------------------------------
{
    my ($self) = @_;
    my  $stack = "Stack: (empty)\n";

    if ($self->{top} >= 0)
    {
        my $width = length $self->{items}->[ $self->{top} ];

        for my $item (@{ $self->{items} }[ 0 .. $self->{top} - 1 ])
        {
            my $new_width = length $item;

            $width = $new_width if $new_width > $width;
        }

        my $top = 1;
        my $bar = sprintf '+-%s-+', '-' x $width;
        $stack  = "Stack: $bar\n";

        for my $item (reverse @{ $self->{items} })
        {
            $stack .= sprintf "       | %*s |%s\n       %s\n",
                      $width, $item, $top ? ' <- top' : '', $bar;

            $top = 0;
        }
    }

    return $stack;
}

###############################################################################
1;
###############################################################################
