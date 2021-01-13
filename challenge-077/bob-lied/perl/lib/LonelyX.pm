# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# LonelyX.pm
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Description:
#=============================================================================

package LonelyX;

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

use File::Slurper qw/ read_lines /;
use List::Util    qw/ all /;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw();
our @EXPORT_OK = qw();

sub new($class, @args)
{
    $class = ref($class) || $class;
    my $self = {
        _grid => [],
        _lastRow => 0,
        _lastCol => 0,

        _lonelyPosition => [],
    };
    bless $self, $class;
    return $self;
}

sub run($self)
{
    my $g = $self->{_grid};
    my $lastRow = $self->{_lastRow};
    my $lastCol = $self->{_lastCol};
    my $pos = $self->{_lonelyPosition};
    my $count = 0;

    # We put a border of Os around so we can walk around
    # an inner rectangle without constantly having to check
    # for border conditions
    for my $row ( 1 .. ($lastRow-1) )
    {
        for my $col ( 1 .. ($lastCol-1) )
        {
            next unless $g->[$row][$col] eq 'X';
            if ( $self->isLonely($row, $col) )
            {
                $count++;
                push @{$pos}, [ $row, $col ];
            }
        }
    }
    return $count;
}

sub getPosition($self)
{
    return $self->{_lonelyPosition};
}

sub highlight($self)
{
    my $grid = $self->{_grid};
    my $lastRow = $self->{_lastRow};
    my $lastCol = $self->{_lastCol};
    my $pos = $self->{_lonelyPosition};

    # Make a deep copy of the grid so that we can change
    # the characters in it.
    my @g;
    for my $row ( 0 .. $lastRow )
    {
        for my $col ( 0 .. $lastCol )
        {
            if ( $grid->[$row][$col] eq 'O' )
            {
                $g[$row][$col] = '.';
            }
            else
            {
                $g[$row][$col] = '*';
            }
        }
    }
    for my $p ( @$pos )
    {
        my ($r, $c) = @$p;
        $g[$r][$c] = 'X';
    }
    # Drop the border for display
    shift @g;
    pop @g;
    for my $row ( @g )
    {
        shift @$row; pop @$row;
        say "[ ", join(" ", @$row), " ]";
    }
}

sub isLonely($self, $row, $col)
{
    my $g = $self->{_grid};

    my @neighbors = ( @{$g->[$row-1]}[$col -1, $col, $col+1],
                      @{$g->[$row  ]}[$col -1,       $col+1],
                      @{$g->[$row+1]}[$col -1, $col, $col+1] );

    my $isLonely = List::Util::all { $_ eq 'O' } @neighbors;
    return $isLonely;
}

sub loadGrid($self, $path)
{
    my $g = $self->{_grid};

    my @txt = File::Slurper::read_lines($path);   
    for my $line (@txt)
    {
        $line =~ tr/[]//d;
        my @row = split(" ", $line);
        # Put a border of zeroes around the grid
        push @{$g}, [ 'O', @row, 'O' ];
    }

    my @zeroRow = (('O') x scalar(@{$g->[0]}) );
    
    unshift @$g, \@zeroRow;
    push    @$g, \@zeroRow;
    
    # Save dimensions
    $self->{_lastRow} = scalar(@$g) - 1;
    $self->{_lastCol} = scalar( @{$g->[0]} ) -1;
}

sub showGrid($self)
{
    my $g = $self->{_grid};
    for my $row ( @$g )
    {
        say "[ ", join(" ", @$row), " ]";
    }
}

1;

