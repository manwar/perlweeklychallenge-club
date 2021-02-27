#!/usr/bin/env raku

# Finds all factor pairs of a given numbers
sub factors(Int $n) returns Positional {
    my $max = $n.sqrt.floor;
    my $number = 1;
    my @factors;
    while $number <= $max {
        my $potential-factor = $n / $number;
        if $potential-factor == $potential-factor.Int {
            @factors.push(($number.clone, $potential-factor));
        }
        $number++;
    }
    @factors;
}

# Formats a 2D array into a multi-line string
sub format(@two-d) returns Str {
    my $width = @two-d[*;*].max(*.chars).chars;
    my @formatted = gather {
        for @two-d -> @row {
            take @row.map(-> $num { sprintf('%*s', $width, $num) }).join(' ');
        }
    }
    @formatted.join("\n");
}

sub challenge(@A) returns Str {
    enum Direction <NORTH EAST SOUTH WEST>;

    my @factors = factors(@A.elems);
    my ($m, $n) = @factors.min(-> ($a, $b) { abs($a - $b) });
    my (@matrix, @output);
    for ^$m {
        my (@matrix-row, @output-row);
        for ^$n {
            @matrix-row.push({ :!visited });
            @output-row.push(Nil)
        }
        @matrix.push(@matrix-row);
        @output.push(@output-row);
    }

    sub visit-cell($i, $j, $element) {
        my %cell = @matrix[$i][$j];
        if !%cell<visited> {
            @output[$i][$j] = $element;
        }
        @matrix[$i][$j]<visited> = True;
    }

    my ($min-row, $min-col) = 0, 0;
    my ($max-row, $max-col) = @matrix.elems - 1, @matrix.tail.elems - 1;
    my ($current-row, $current-col, $current-direction) = $min-row, $min-col, EAST;

    for @A -> $element {
        visit-cell($current-row, $current-col, $element);
        given $current-direction {
            when EAST {
                if $current-col == $max-col || @matrix[$current-row][$current-col+1]<visited> {
                    $current-direction = SOUTH;
                    $current-row += 1;
                } else {
                    $current-col += 1;
                }
            }
            when SOUTH {
                if ($current-row == $max-row && $current-col == $max-col) || @matrix[$current-row+1][$current-col]<visited> {
                    $current-direction = WEST;
                    $current-col -= 1;
                } else {
                    $current-row += 1;
                }
            }
            when WEST {
                if $current-col == $min-col || @matrix[$current-row][$current-col-1]<visited> {
                    $current-direction = NORTH;
                    $current-row -= 1;
                } else {
                    $current-col -= 1;
                }
            }
            when NORTH {
                # No need to check for special case here, because we always start in the top left
                if @matrix[$current-row-1][$current-col]<visited> {
                    $current-direction = EAST;
                    $current-col += 1;
                } else {
                    $current-row -= 1;
                }
            }
        }
    }

    format(@output.reverse);
}

multi sub MAIN(*@A) {
    say challenge(@A);
}

multi sub MAIN(Bool :$test) {
    use Test;

    my @tests = (
        ((1..4), "4 3\n1 2"),
        ((1..6), "6 5 4\n1 2 3"),
        ((1..12), " 9  8  7  6\n10 11 12  5\n 1  2  3  4")
    );

    for @tests -> (@input, $expected) {
        is(challenge(@input), $expected);
    }

    done-testing;
}
