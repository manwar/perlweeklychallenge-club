# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Grid.pm
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# Description:
#=============================================================================

use v5.40;
use feature 'class'; no warnings "experimental::class";

class AOC::Grid;

field $_grid   :param(grid)   = [["?"]];
field $_height :param(height) = 0;      # Last index
field $_width  :param(width)  = 0;      # Last index


method grid()   { ${_grid} }
method height() { ${_height} }
method width()  { ${_width} }

method get($row, $col) { ${_grid}->[$row][$col] }

method isValidRow($row) { $row >= 0 && $row <= $self->height() }
method isValidCol($col) { $col >= 0 && $col <= $self->width()  }
method isInbounds($row, $col)
{
    $self->isValidRow($row) && $self->isValidCol($col)
}

method set($row, $col, $val) { $_grid->[$row][$col] = $val; return $self; }

method north($row, $col) { return ( $row > 0 ? [$row-1, $col] : undef ) }
method south($row, $col) { return ( $row < $self->height() ? [$row+1, $col] : undef ) }
method west( $row, $col) { return ( $col > 0 ? [$row, $col-1] : undef ) }
method east( $row, $col) { return ( $col < $self->width  ? [$row, $col+1] : undef ) }

# Get coordinates of valid positions around the given cell.
# Returns 2 to 4 values, depending on edges and corners.
method neighborNESW($r, $c)
{
    grep { ( 0 <= $_->[0] <= $self->height() ) && 
                   ( 0 <= $_->[1] <= $self->width() ) }
        ( [$r-1, $c], [$r, $c+1], [$r+1, $c], [$r, $c-1] );
}

# Return list of values and their coordinates,
# [ a b c d ]
# [ e f g h ]
# [ i j k l ]
# eg. aroundNESW(1,1) is [ ['b', [0,1]], ['g',[1,2]], ['j',[2,1]], ['e',[1,0]] ]
# in the order N,E,S,W.  May be fewer if at edge,
# e.g., aroundNESW(0,0) is [ ['b',[0,1]], ['e', [1,0]] ]
method aroundNESW($r, $c)
{
    map { [ $_grid->[$_->[0]][$_->[1]] => $_  ] } $self->neighborNESW($r, $c);
}

method show()
{
    my $grid = $self->grid();
    my $height = $self->height();
    my $width  = $self->width();
    my $colFormat = " %2s" x ($width+1);
    my $s = "\n";

    $s .= sprintf("     $colFormat\n", 0 .. $width);
    $s .=         "   + " . (" --" x ($width+1)) . "+\n";
    for my $row ( 0 .. $height )
    {
        $s .= sprintf(" %2s |$colFormat | %-2s\n", $row, $grid->[$row]->@*, $row);
    }
    $s .=          "   + " . (" --" x ($width+1)) . "+\n";
    $s .= sprintf( "     $colFormat\n", 0 .. $width);
    return $s;
}

sub loadGrid
{
    my @g;
    while (<>)
    {
        chomp;
        push @g, [ split // ];
    }
    return AOC::Grid->new(grid=>\@g, height=>$#g, width=> $g[0]->$#*);
}

sub makeGrid($height, $width, $val)
{
    my @g;
    push @g, [ ($val) x ($width+1) ] for 0 .. $height;
    return AOC::Grid->new(grid=>\@g, height=>$height, width=>$width);
}

sub clone($self)
{
    my @new;
    my $g = $self->grid();
    for my $r ( 0 .. $self->height() )
    {
        push @new, [ $g->[$r]->@* ];
    }
    return AOC::Grid->new(grid=>\@new, height=>$self->height, width=>$self->width);
}

1;
