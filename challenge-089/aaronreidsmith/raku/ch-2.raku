#!/usr/bin/env perl6

subset OddPositiveInt of Int where { $_ ~~ Int && $_ > 0 && !($_ %% 2) }

sub MAIN($side-length where $side-length ~~ OddPositiveInt = 3, $debug where $debug ~~ Bool = False) {
    my @matrix = generate-matrix($side-length);
    my @filled-in-matrix = fill-in-matrix(@matrix, $side-length);
    for @filled-in-matrix -> @row {
        say '[ ' ~ @row.join(' ') ~ ' ]';
    }
    if $debug {
        print "\n";
        validate-matrix(@filled-in-matrix, $side-length);
    }
}

# Generate a 2D matrix that we can fill in with the proper numbers.
# For 3x3 it would output:
#  [0 0 0]
#  [0 0 0]
#  [0 0 0]
sub generate-matrix($side-length) {
    my @matrix = Array.new;
    for ^$side-length -> $i {
        my @row = Array.new;
        for (($i * $side-length) + 1..($i * $side-length) + $side-length) {
            @row.push(0);
        }
        @matrix.push(@row);
    }
    @matrix
}

# Actual business logic here. It takes the empty array and fills it in to be "magic"
# Such that all rows, columns, and the two diagonals add up to $side-length * ($side-length² + 1) / 2
sub fill-in-matrix(@matrix, $side-length) {
    my $num = 1;
    my $row = floor($side-length / 2);
    my $col = $side-length - 1;

    while $num <= $side-length² {
        if $row == -1 && $col == $side-length {
            $col = $side-length - 2;
            $row = 0;
        } else {
            if $col == $side-length {
                $col = 0;
            }
            if $row < 0 {
                $row = $side-length - 1;
            }
        }
        if @matrix[$row][$col] != 0 {
            $col -= 2;
            $row++;
        } else {
            @matrix[$row][$col] = $num;
            $num++;
            $col++;
            $row--;
        }
    }
    @matrix;
}

# Helper function to validate output matrix and print the validation
sub validate-matrix(@matrix, $side-length) {
    my @rows = @matrix;
    my @columns = [Z] @matrix;
    my @diagonal = @matrix.kv.map(-> $i, @row { @row[$i] });
    my @counter-diagonal = @matrix.kv.map(-> $i, @row { @row[*-$i-1] });

    my $target = ($side-length * ($side-length² + 1) / 2).Int;

    my $valid-rows = so @rows.map(-> @row { [+] @row }).all == $target;
    my $valid-cols = so @columns.map(-> @column { [+] @column }).all == $target;
    my $valid-diag = so ([+] @diagonal) == $target;
    my $valid-counter-diag = so ([+] @counter-diagonal) == $target;

    if $valid-rows && $valid-cols && $valid-diag && $valid-counter-diag {
        for @rows -> @row {
            say @row.join(' + ') ~ ' = ' ~ $target;
        }
        for @columns -> @column {
            say @column.join(' + ') ~ ' = ' ~ $target;
        }
        say @diagonal.join(' + ') ~ ' = ' ~ $target;
        say @counter-diagonal.join(' + ') ~ ' = ' ~ $target;
    } else {
        die "Not a valid magic matrix";
    }
}
