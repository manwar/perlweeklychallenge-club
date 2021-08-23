use strict;
use warnings;

# my input data
# an assumption is made here that the size of the
# array will always be MxN, which means no row or col
# will have extra element in comparison with the others
my @board = (
    ['x', '*', '*', '*', 'x', '*', 'x', 'x', 'x', 'x'],
    ['*', '*', '*', '*', '*', '*', '*', '*', '*', 'x'],
    ['*', '*', '*', '*', 'x', '*', 'x', '*', 'x', '*'],
    ['*', '*', '*', 'x', 'x', '*', '*', '*', '*', '*'],
    ['x', '*', '*', '*', 'x', '*', '*', '*', '*', 'x']
);

sub _get_rows_cols {
    my @arr = @_;

    my $rows;
    my $cols;
    my @inner;

    $rows = $#arr;
    # deref an inner array and get the length
    @inner = @{$board[$rows]}; 
    $cols = $#inner;

    return +{rows => $rows, cols => $cols};
}

sub _traverse_array {
    my $cords = shift;
    my $board = shift;

    my $rows = $cords->{rows};
    my $cols = $cords->{cols};

    foreach my $r (0..$rows) {
        foreach my $c (0..$cols) {
            if ($board[$r][$c] eq "*") {
                $board[$r][$c] = 0;
            }
        }
    }

    foreach my $r (0..$rows) {
        foreach my $c (0..$cols) {
            if ($board[$r][$c] eq "x") {
                _visit_neighbours_apply_numbers($r, $c, @board, $rows, $cols);
                _print_array($cords, @board);
                print "\n\n";
            }
        }
    }
}

sub _visit_neighbours_apply_numbers {
    my $row   = shift;
    my $col   = shift;
    my $board = shift;
    my $rows  = shift;
    my $cols  = shift;

    $board[$row-1][$col-1]++ unless !defined($board[$row-1][$col-1]) || $board[$row-1][$col-1] eq "x" || $row-1 < 0 || $col-1 < 0;
    $board[$row-1][$col]++   unless !defined($board[$row-1][$col])   || $board[$row-1][$col] eq "x"   || $row-1 < 0;
    $board[$row-1][$col+1]++ unless !defined($board[$row-1][$col+1]) || $board[$row-1][$col+1] eq "x" || $row-1 < 0;

    $board[$row][$col-1]++   unless !defined($board[$row][$col-1])   || $board[$row][$col-1] eq "x"   || $col-1 < 0;
    $board[$row][$col+1]++   unless !defined($board[$row][$col+1])   || $board[$row][$col+1] eq "x";

    $board[$row+1][$col-1]++ unless !defined($board[$row+1][$col-1]) || $board[$row+1][$col-1] eq "x" || $col-1 < 0;
    $board[$row+1][$col]++   unless !defined($board[$row+1][$col])   || $board[$row+1][$col] eq "x";
    $board[$row+1][$col+1]++ unless !defined($board[$row+1][$col+1]) || $board[$row+1][$col+1] eq "x";

}

sub _print_array {
    my $cords = shift;
    my $board = shift;

    my $rows = $cords->{rows};
    my $cols = $cords->{cols};

    foreach my $r (0..$rows) {
        foreach my $c (0..$cols) {
            print "$board[$r][$c] ";
        }
        print "\n";
    }
}

# main code 

# get the rows and cols of the array
my $cords = _get_rows_cols(@board);

# traverse the array
_traverse_array($cords, @board);

_print_array($cords, @board);
