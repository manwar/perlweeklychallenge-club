#!perl

###############################################################################
=comment

Perl Weekly Challenge 086
=========================

Task #2
-------
*Sudoku Puzzle*

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

###############################################################################
package Sudoku;
###############################################################################

use strict;
use warnings;
use Class::Tiny qw( grid );
use Const::Fast;
use Set::Scalar;
use constant DEBUG => 0;

const my $EMPTY_CELL => '_';

#==============================================================================
# Public methods
#==============================================================================

#------------------------------------------------------------------------------
sub BUILD
#------------------------------------------------------------------------------
{
    my ($self, $args) = @_;

    if    (defined(my $orig = $args->{clone}))
    {
        $self->clone($orig);
    }
    elsif (defined(my $file = $args->{file}))
    {
        $self->_read_from_file($file);
    }
    else
    {
        die 'ERROR: Invalid constructor call, stopped';
    }
}

#------------------------------------------------------------------------------
sub clone
#------------------------------------------------------------------------------
{
    my ($self, $orig) = @_;

    for my $row (0 .. 8)
    {
        for my $col (0 .. 8)
        {
            $self->{grid}[$row][$col] = $orig->{grid}[$row][$col];
        }
    }
}

#------------------------------------------------------------------------------
sub insert
#------------------------------------------------------------------------------
{
    my ($self, $row, $col, $digit) = @_;

    if ($digit !~ /^[1-9]$/)
    {
        die qq[ERROR: Invalid digit "$digit", stopped];
    }

    my $target = \$self->{grid}[$row][$col];

    if ($$target ne $EMPTY_CELL)
    {
        die qq[ERROR: Cannot add "$digit" at position ($row, $col) which ] .
            qq[already contains "$$target", stopped];
    }

    $$target = $digit;
}

#------------------------------------------------------------------------------
sub display
#------------------------------------------------------------------------------
{
    my ($self)   = @_;
    my  $display = '';

    for my $row (0 .. 8)
    {
        $display .= sprintf " [ %s ]\n", join ' ', $self->{grid}[$row]->@*;
    }

    return $display;
}

#------------------------------------------------------------------------------
sub is_valid
#------------------------------------------------------------------------------
{
    my ($self) = @_;

    return $self->_rows_are_valid &&
           $self->_cols_are_valid &&
           $self->_boxes_are_valid;
}

#------------------------------------------------------------------------------
sub count_empty_cells
#------------------------------------------------------------------------------
{
    my ($self) = @_;
    my  $count = 0;

    for my $row (0 .. 8)
    {
        for my $col (0 .. 8)
        {
            ++$count if $self->{grid}[$row][$col] eq $EMPTY_CELL;
        }
    }

    return $count;
}

#------------------------------------------------------------------------------
sub select_empty_cell
#------------------------------------------------------------------------------
{
    my ($self) = @_;
    my  %cells;

    for my $row (0 .. 8)
    {
        for my $col (0 .. 8)
        {
            if ($self->{grid}[$row][$col] eq $EMPTY_CELL)
            {
                my @possibles = $self->_find_possible_digits($row, $col);

                my %cell = (row => $row, col => $col, digits => \@possibles);

                push $cells{scalar @possibles}->@*, \%cell;
            }
        }
    }

    my $least = (sort { $a <=> $b } keys %cells)[0];

    return $cells{$least}->[0];
}


#==============================================================================
# Private methods
#==============================================================================

#------------------------------------------------------------------------------
sub _read_from_file
#------------------------------------------------------------------------------
{
    my ($self, $file) = @_;

    open(my $fh, '<', $file)
        or die qq[ERROR: Cannot open file "$file" for reading, stopped];

    for my $row (0 .. 8)
    {
        my $line = <$fh>;
        chomp $line;
        my @digits = split /\s+/, $line;

        for my $col (0 .. 8)
        {
            my $digit = shift @digits;

            defined $digit
                or die qq[ERROR: Missing character in file "$file", stopped];

            $digit =~ /[1-9$EMPTY_CELL]/
                or die qq[ERROR: Invalid character "$digit" in file ] .
                       qq["$file", stopped];

            $self->{grid}[$row][$col] = $digit;
        }
    }

    close $fh
        or die qq[ERROR: Cannot close file "$file", stopped];
}

#------------------------------------------------------------------------------
sub _rows_are_valid
#------------------------------------------------------------------------------
{
    my ($self) = @_;

    for my $row (0 .. 8)
    {
        my %digits;

        for my $col (0 .. 8)
        {
            my $digit = $self->{grid}[$row][$col];
            my $count = ++$digits{$digit};

            if ($digit ne $EMPTY_CELL && $count > 1)
            {
                warn qq[Rule a): Digit "$digit" occurs more than once in ] .
                     qq[row $row\n] if DEBUG;

                return 0;
            }
        }
    }

    return 1;
}

#------------------------------------------------------------------------------
sub _cols_are_valid
#------------------------------------------------------------------------------
{
    my ($self) = @_;

    for my $col (0 .. 8)
    {
        my %digits;

        for my $row (0 .. 8)
        {
            my $digit = $self->{grid}[$row][$col];
            my $count = ++$digits{$digit};

            if ($digit ne $EMPTY_CELL && $count > 1)
            {
                warn qq[Rule b): Digit "$digit" occurs more than once in ] .
                     qq[column $col\n] if DEBUG;

                return 0;
            }
        }
    }

    return 1;
}

#------------------------------------------------------------------------------
sub _boxes_are_valid
#------------------------------------------------------------------------------
{
    my ($self) = @_;

    for my $row (0, 3, 6)
    {
        for my $col (0, 3, 6)
        {
            my %digits;

            for my $r ($row .. $row + 2)
            {
                for my $c ($col .. $col + 2)
                {
                    my $digit = $self->{grid}[$r][$c];
                    my $count = ++$digits{$digit};

                    if ($digit ne $EMPTY_CELL && $count > 1)
                    {
                        warn qq[Rule c): Digit "$digit" occurs more than ] .
                             qq[once in box ($row, $col)\n] if DEBUG;

                        return 0;
                    }
                }
            }
        }
    }

    return 1;
}

#------------------------------------------------------------------------------
sub _find_possible_digits
#------------------------------------------------------------------------------
{
    my ($self, $row, $col) = @_;
    my  $possibles = Set::Scalar->new(1 .. 9);

    for my $c (0 .. 8)
    {
        $possibles->delete($self->{grid}[$row][$c]);
    }

    for my $r (0 .. 8)
    {
        $possibles->delete($self->{grid}[$r][$col]);
    }

    my $box_row = $row - ($row % 3);
    my $box_col = $col - ($col % 3);

    for my $r ($box_row .. $box_row + 2)
    {
        for my $c ($box_col .. $box_col + 2)
        {
            $possibles->delete($self->{grid}[$r][$c]);
        }
    }

    return sort { $a <=> $b } $possibles->members;
}

###############################################################################
1;
###############################################################################
