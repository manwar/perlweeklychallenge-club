# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# LargestRectangleHistogram.pm
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Description:
#=============================================================================

package LargestRectangleHistogram;

use strict;
use warnings;
use feature qw(say);

use List::Util qw(max min);
use List::MoreUtils qw(arrayify); # Flattens 2D array into a list

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw();
our @EXPORT_OK = qw();

sub _setup
{
    my $self = shift;

    for my $row ( 0 .. $self->{_numRow} -1 )
    {
        for my $col ( 0 .. $self->{_numCol}-1 )
        {
            $self->{_grid}->[$row][$col] = ( $self->{_list}->[$col] > $row ? '*' : ' ' );
            $self->{_area}->[$row][$col] = 0;
        }
    }
}

sub new
{
    my $class = shift;
    $class = ref($class) || $class;
    my $self = {
        _list => [ @_ ],
        _numCol  => scalar(@_),
        _numRow  => List::Util::max( @_ ),

        _grid => undef,
        _area => undef,
        _extent => undef,

    };
    bless $self, $class;

    $self->_setup();
    return $self;
}

sub _extendLeft
{
    my $self = shift;
    my ($r, $col) = @_;
    my $row = $self->{_grid}->[$r];

    $col-- while ( $col >= 0 && $row->[$col] eq '*' );
    return $col+1;
}

sub _extendRight
{
    my $self = shift;
    my ($r, $col) = @_;
    my $row = $self->{_grid}->[$r];

    $col++ while ( $col < $self->{_numCol} && $row->[$col] eq '*' );
    return $col -1;
}

sub _extend
{
    my $self = shift;
    my ($row, $col) = @_;
    my $ext = $self->{_extent};

    # Memoize the range if already calculated
    return @{$ext->[$row][$col]} if exists $ext->[$row][$col];

    my $maxCol = $self->_extendRight($row, $col);
    my $minCol = $self->_extendLeft($row, $col);

    $ext->[$row][$col] = [ $minCol, $maxCol ] for $minCol .. $maxCol;
    return ($minCol, $maxCol);
}

sub _findArea
{
    my $self = shift;
    my ($row, $col) = @_;
    my $grid = $self->{_grid};

    my ($minCol, $maxCol) = $self->_extend($row, $col);

    my $height = List::Util::min( @{$self->{_list}}[$minCol..$maxCol] );

    my $a = $self->{_area}->[$row][$col] = ( ( $maxCol - $minCol + 1) * $height );

    # say "[$row][$col] : maxL=$minCol maxR=$maxCol height=$height area=$a";
    return $a;

}
sub findLRH
{
    my $self = shift;

    my $grid = $self->{_grid};

    for my $row ( 0 .. $self->{_numRow}-1 )
    {
        for my $col ( 0 .. $self->{_numCol}-1 )
        {
            next unless $grid->[$row][$col] eq '*';
            my $area = $self->_findArea($row, $col);
        }
    }

    return max(arrayify( @{$self->{_area}} ) );
}

sub _show
{
    my $self = shift;
    my $g = $self->{_grid};
    my $numRow = $self->{_numRow}-1;
    my $numCol = $self->{_numCol}-1;

    print "    ";
    for my $c ( 0 .. $numCol )
    {
        print "[$c]";
    }
    print "\n";
    for my $r ( 0 .. $numRow )
    {
        print "[$r] ";
        say " ", join('  ', @{$g->[$r]}), " ";
    }


}

sub display
{
    my $self = shift;
    my @chart;

    for ( my $row = $self->{_numRow}-1 ; $row >= 0 ; $row-- )
    {
        printf("%2d| ", $row+1);
        my $line = join(' ', @{$self->{_grid}->[$row]});
        say $line;
    }
    say '  +', ('-' x ($self->{_numCol}*2));
    say '    ', join(' ', @{$self->{_list}});
}

1;

