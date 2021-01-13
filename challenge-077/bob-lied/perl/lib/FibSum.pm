# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# FibSum.pm
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Description:
#=============================================================================

package FibSum;

use strict;
use warnings;

use v5.30;
use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

use Memoize;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw();
our @EXPORT_OK = qw(_fib);  # Not part of interface, but expose for testing.

my @ComboList;

use constant SOLVED => 0;

# The poster child for Memoize.
memoize('_fib');
sub _fib($n)
{
    return $n if $n < 2;
    return _fib($n-1) + _fib($n-2);
}

# Create a list of Fibonacci numbers that are less than
# the target, in descending order.
sub _init($target)
{
    my $f;
    my @fl  = ( 1 );    # Take for granted.
    my $n = 3;          # We can skip 2 because F(2) == 1.
    while ( ($f = _fib($n)) <= $target )
    {
        push @fl, $f;
        $n++;
    }

    return [ reverse @fl ];  # Descending order
}

# Constructor.   Save target and initialize list of
# Fibonacci numbers that can be used to sum to the target.
sub new($class, $n)
{
    $class = ref($class) || $class;
    my $self = {
        _n => $n,

        _f => [],   # List of Fibonacci numbers less than _n
    };
    $self->{_f} = _init($n);
    bless $self, $class;
}

# Accessor.  Should have used Moo.
sub target($self)
{
    return $self->{_n};
}

# Accessor.
sub getFibList($self)
{
    return $self->{_f};
}

# Entry point.
sub run($self)
{
    my @fibs = @{$self->getFibList()};
    @ComboList = ();

    while ( @fibs )
    {
        # say "WORKING ON [ @fibs ]";
        $self->_fibSum(1, $self->target(), \@fibs, $fibs[0], [ $fibs[0] ] );
        shift @fibs;
    }
    return \@ComboList;
}

# Recursive magic. $depth is only here for debugging.
sub _fibSum($self, $depth, $target, $fibList, $fib, $combo)
{
    # say " ", (" " x $depth), "$depth: t=$target, f=$fib, [ @$combo ]";
    my $diff = $target - $fib;

    if ( $diff == 0 )
    {
        # Found an answer.  Save it.
        push @ComboList, [ @$combo ];
        return SOLVED;
    }
    if ( $diff < 0 )
    {
        # Too big.  Give up.
        pop @$combo;
        return $diff;
    }

    # Only allowed to use fib once
    my @remainingFib = grep { $_ != $fib && $_ <= $diff } @$fibList;

    for my $f ( @remainingFib )
    {
        push @$combo, $f;   # Build up the answer.

        # Look for the new, smaller, target number.
        my $attempt = $self->_fibSum($depth+1, $diff, \@remainingFib, $f, $combo);
        pop @$combo;        # Put that one away and go to the next.

        # If we found a solution, we don't need to go through other
        # possibilities because of the constraint to use each Fn only once.
        return 0 if $attempt == SOLVED;
    }
    return $diff;
}

1;

