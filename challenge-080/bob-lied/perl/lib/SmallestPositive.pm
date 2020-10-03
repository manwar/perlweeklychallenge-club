# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# SmallestPositive.pm
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Description:
#=============================================================================

package SmallestPositive;

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

use List::MoreUtils qw/ firstidx /;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw();
our @EXPORT_OK = qw();

sub new($class, @N)
{
    $class = ref($class) || $class;
    my $self = {
    };
    bless $self, $class;

    # Clean up the list to have only positive numbers in sorted order
    $self->{_N} = [ sort { $a <=> $b } grep $_ > 0, @N ];
    return $self;
}

sub run($self)
{
    my @n = @{$self->{_N}};

    # Weed out some special cases.
    if ( @n == 0 ) # Empty list
    {
        return 1;
    }
    elsif ( @n == 1 )
    {
        return ($n[0] == 1 ? 2 : 1);
    }

    # Put a lower bound and upper bound on the list.
    unshift @n, 0;
    push @n, ($n[-1] + 2);

    # Calculate differences between pairs.
    my @delta = map { $n[$_+1] - $n[$_] } ( 0 .. $#n-1 );
    
    # Find the first difference that isn't 1.  We rigged the list
    # to have a +2 at the right end, so there must be one.
    my $place = firstidx { $_ > 1 } @delta;

    return $n[$place] + 1;
}

1;
