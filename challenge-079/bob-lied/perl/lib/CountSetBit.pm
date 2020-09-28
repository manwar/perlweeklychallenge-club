# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# CountSetBit.pm
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Description:
#=============================================================================

package CountSetBit;

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw();
our @EXPORT_OK = qw();

sub new($class, $n)
{
    $class = ref($class) || $class;
    my $self = {
        _n => $n,

        _sum => 0,
    };
    bless $self, $class;
    return $self;
}

# https://www.techiedelight.com/brian-kernighans-algorithm-count-set-bits-integer/
sub run($self)
{
    $self->{_sum} += $self->_bitsOf($_) for ( 1 .. $self->{_n} );
    return ( $self->{_sum} % 1000000007 );
}

sub _bitsOf($self, $n)a
{
    my $count = 0;

    while ( $n > 0 )
    {
        $count++;
        $n = $n & ($n-1);
    }
    return $count;
}

1;
