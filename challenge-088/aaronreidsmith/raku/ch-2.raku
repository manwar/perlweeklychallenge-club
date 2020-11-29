#!/usr/bin/env perl6

subset PositiveInt of Int where { $_ ~~ Int && $_ > 0 }

enum Direction <NORTH EAST SOUTH WEST>;

sub USAGE {
    print Q:c:to/EOH/;
    Usage: {$*PROGRAM-NAME} <matrix>

    Example: {$*PROGRAM-NAME} 1 2 3 4 5 6 7 8 9
EOH
}

sub MAIN(*@input where all(@input) ~~ PositiveInt && @input.elems > 0) {
    # Ensure our input is exactly square
    my $side-length = @input.elems.sqrt;
    $side-length.Int == $side-length or die "Must be a square matrix";

    # Turn our CLI input into a list of lists (containing both the value and a flag for if we have visted it)
    my @matrix = gather {
        loop (my $i = 0; $i < @input.elems; $i += $side-length) {
            my @row = @input[$i..^$i + $side-length].map({ Hash.new('value', $_, 'visited', False) });
            take @row;
        }
    }

    # Output list and helper function for adding to it
    my @output;
    sub visit-cell($i, $j) {
        my %cell = @matrix[$i][$j];
        if !%cell{'visited'} {
            @output.push(%cell{'value'});
        }
        @matrix[$i][$j]{'visited'} = True;
    }

    # Control vars used below
    my ($min-row, $min-col) = 0, 0;
    my ($max-row, $max-col) = @matrix.elems - 1, @matrix.tail.elems - 1;
    my ($current-row, $current-col, $current-direction) = $min-row, $min-col, EAST;

    # Iterate through matrix in the given directions. Check if we are in a corner or if we have already
    # visited the next cell to determine if we should turn
    while @output.elems != @input.elems {
        visit-cell($current-row, $current-col);
        given $current-direction {
            when EAST {
                if $current-col == $max-col || @matrix[$current-row][$current-col+1]{'visited'} {
                    $current-direction = SOUTH;
                    $current-row += 1;
                } else {
                    $current-col += 1;
                }
            }
            when SOUTH {
                if ($current-row == $max-row && $current-col == $max-col) || @matrix[$current-row+1][$current-col]{'visited'} {
                    $current-direction = WEST;
                    $current-col -= 1;
                } else {
                    $current-row += 1;
                }
            }
            when WEST {
                if $current-col == $min-col || @matrix[$current-row][$current-col-1]{'visited'} {
                    $current-direction = NORTH;
                    $current-row -= 1;
                } else {
                    $current-col -= 1;
                }
            }
            when NORTH {
                # No need to check for special case here, because we always start in the top left
                if @matrix[$current-row-1][$current-col]{'visited'} {
                    $current-direction = EAST;
                    $current-col += 1;
                } else {
                    $current-row -= 1;
                }
            }
        }
    }
    say @output;
}
