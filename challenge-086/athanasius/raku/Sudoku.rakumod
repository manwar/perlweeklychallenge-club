use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 086
=========================

Task #2
-------
*Sudoku Puzzle*

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

###############################################################################
unit class Sudoku;
###############################################################################

my Str constant $EMPTY-CELL = '_';
my     constant @DIGITS     = Array[Str].new: '1' .. '9';

subset Cell  of Str where { .all ⊂ @DIGITS ∪ $EMPTY-CELL };
subset Digit of Str where { .all ⊂ @DIGITS };

has Cell @.grid[9; 9];
has Str  $!file;

##=============================================================================
# Public methods
##=============================================================================

#------------------------------------------------------------------------------
submethod BUILD( Str:D :$!file = '' )
#------------------------------------------------------------------------------
{
    if $!file
    {
        my Str @lines = $!file.IO.lines;

        for 0 .. 8 -> UInt $row
        {
            my Cell @digits = @lines[$row].split: /\s+/;

            for 0 .. 8 -> UInt $col
            {
                @!grid[$row; $col] = @digits.shift;
            }
        }
    }
}

#------------------------------------------------------------------------------
method clone( Sudoku:D $orig --> Sudoku:D )
#------------------------------------------------------------------------------
{
    my $new-self = Sudoku.new;

    for 0 .. 8 -> UInt $row
    {
        for 0 .. 8 -> UInt $col
        {
            $new-self.grid[$row; $col] = $orig.grid[$row; $col];
        }
    }

    return $new-self;
}

#------------------------------------------------------------------------------
method insert( UInt:D $row, UInt:D $col, Digit:D $digit )
#------------------------------------------------------------------------------
{
    my Cell $target = @!grid[$row; $col];

    $target eq $EMPTY-CELL
        or die qq[ERROR: Cannot add "$digit" at position ($row, $col) which ] ~
               qq[already contains "$target"];

    @!grid[$row; $col] = $digit;
}

#------------------------------------------------------------------------------
method display( --> Str:D )
#------------------------------------------------------------------------------
{
    my Str $display = '';

    for 0 .. 8 -> UInt $row
    {
        $display ~= ' [';

        for 0 .. 8 -> UInt $col
        {
            $display ~= ' ' ~ @!grid[$row; $col];
        }

        $display ~= " ]\n";
    }

    return $display;
}

#------------------------------------------------------------------------------
method is-valid( --> Bool:D )
#------------------------------------------------------------------------------
{
    return self!rows-are-valid &&
           self!cols-are-valid &&
           self!boxes-are-valid;
}

#------------------------------------------------------------------------------
method count-empty-cells( --> UInt:D )
#------------------------------------------------------------------------------
{
    my UInt $count = 0;

    for 0 .. 8 -> UInt $row
    {
        for 0 .. 8 -> UInt $col
        {
            ++$count if @!grid[$row; $col] eq $EMPTY-CELL;
        }
    }

    return $count;
}

#------------------------------------------------------------------------------
class Cell-Options
#------------------------------------------------------------------------------
{
    has UInt  $.row;
    has UInt  $.col;
    has Digit @.digits;
}

#------------------------------------------------------------------------------
method select-empty-cell( --> Cell-Options:D )
#------------------------------------------------------------------------------
{
    my Array[Cell-Options] %cells;

    for 0 .. 8 -> UInt $row
    {
        for 0 .. 8 -> UInt $col
        {
            if @!grid[$row; $col] eq $EMPTY-CELL
            {
                my Digit @digits = self!find-possible-digits($row, $col);

                %cells{ @digits.elems }.push:
                    Cell-Options.new(:row($row), :col($col), :digits(@digits));
            }
        }
    }

    return %cells{ %cells.keys.sort[0] }[0];
}

##=============================================================================
# Private methods
##=============================================================================

#------------------------------------------------------------------------------
method !rows-are-valid( --> Bool:D )
#------------------------------------------------------------------------------
{
    for 0 .. 8 -> UInt $row
    {
        my UInt %digits;

        for 0 .. 8 -> UInt $col
        {
            my Cell $digit = @!grid[$row; $col];
            my UInt $count = ++%digits{ $digit };

            return False if $digit ne $EMPTY-CELL && $count > 1;
        }
    }

    return True;
}

#------------------------------------------------------------------------------
method !cols-are-valid( --> Bool:D )
#------------------------------------------------------------------------------
{
    for 0 .. 8 -> UInt $col
    {
        my UInt %digits;

        for 0 .. 8 -> UInt $row
        {
            my Cell $digit = @!grid[$row; $col];
            my UInt $count = ++%digits{ $digit };

            return False if $digit ne $EMPTY-CELL && $count > 1;
        }
    }

    return True;
}

#------------------------------------------------------------------------------
method !boxes-are-valid( --> Bool:D )
#------------------------------------------------------------------------------
{
    for 0, 3, 6 -> UInt $row
    {
        for 0, 3, 6 -> UInt $col
        {
            my UInt %digits;

            for $row .. $row + 2 -> UInt $r
            {
                for $col .. $col + 2 -> UInt $c
                {
                    my Cell $digit = @!grid[$r; $c];
                    my UInt $count = ++%digits{ $digit };

                    return False if $digit ne $EMPTY-CELL && $count > 1;
                }
            }
        }
    }

    return True;
}

#------------------------------------------------------------------------------
method !find-possible-digits( UInt:D $row, UInt:D $col --> Seq:D[Digit:D] )
#------------------------------------------------------------------------------
{
    my Set $possibles = set '1' .. '9';

    for 0 .. 8 -> UInt $c
    {
        $possibles = $possibles (-) @!grid[$row; $c];
    }

    for 0 .. 8 -> UInt $r
    {
        $possibles = $possibles (-) @!grid[$r; $col];
    }

    my UInt $box-row = $row - ($row % 3);
    my UInt $box-col = $col - ($col % 3);

    for $box-row .. $box-row + 2 -> UInt $r
    {
        for $box-col .. $box-col + 2 -> UInt $c
        {
            $possibles = $possibles (-) @!grid[$r; $c];
        }
    }

    return $possibles.keys.sort;
}

###############################################################################
