# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# TrappedRainWater.pm
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Description:
#=============================================================================

package TrappedRainWater;

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

use List::Util qw/ max /;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw();
our @EXPORT_OK = qw();

sub new($class, $listref)
{
    $class = ref($class) || $class;
    my $self = {
        _list => $listref,
        _numCol => scalar(@$listref),
        _numRow => List::Util::max(@$listref),

        _grid => [],
        _trap => [],
    };
    bless $self, $class;

    $self->_setup();
    return $self;
}

sub _setup($self)
{
    my ($lst, $trap, $g, $numRow, $numCol) = @{$self}{ qw(_list _trap _grid _numRow _numCol) };

    for ( my $r = 0; $r < $numRow ; $r++ )
    {
        for ( my $c = 0; $c < $numCol; $c++ )
        {
            $g->[$r][$c] = ( $lst->[$c] > $r ? '#' : ' ');
            $trap->[$r][$c] = 0;
        }
    }
}

sub show($self)
{
    my ($g, $numRow, $numCol) = @{$self}{ qw(_trap _numRow _numCol) };
    print "    ";
    for ( my $c = 0 ; $c < $numCol; $c++ )
    {
        print "[$c]";
    }
    print "\n";
    for ( my $r = $numRow - 1; $r >= 0 ; $r-- )
    {
        print "[$r] ";
        say " ", join('  ', @{$g->[$r]}), " ";
    }

}

sub _hasWall($self)
{
    my $sawWall = 0;
    my $g = $self->{_grid};
    my $trap = $self->{_trap};

    for (my $r = 0 ; $r < $self->{_numRow} ; $r++ )
    {
        # Increment count if there's a wall on the left
        for (my $c = 0 ; $c < $self->{_numCol} ; $c++ )
        {
            if    ( $g->[$r][$c] eq '#' ) { $sawWall = 1 }
            elsif ( $sawWall )            { $trap->[$r][$c]++ }
        }
        # Increment count if there's a wall on the right
        $sawWall = 0;
        for (my $c = $self->{_numCol}-1 ; $c >= 0 ; $c-- )
        {
            if    ( $g->[$r][$c] eq '#' ) { $sawWall = 1 }
            elsif ( $sawWall )            { $trap->[$r][$c]++ }
        }
        $sawWall = 0;
    }
    # Assume there's a wall on the bottom (all list values are > 0).
}

sub run($self)
{
    $self->_hasWall();

    my @flattrap = map { ref eq 'ARRAY' ? @$_ : $_ } @{$self->{_trap}};

    my $holdsWater = grep { $_ == 2 } @flattrap;
    return $holdsWater;
}

1;
