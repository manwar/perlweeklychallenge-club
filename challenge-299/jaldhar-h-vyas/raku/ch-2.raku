#!/usr/bin/raku

sub traverse(@grid, @string, %visited, $row, $col) {
    state @directions = ([-1, 0], [0,  1], [1,  0], [0, -1]);

    unless @string.elems {
        return True;
    }

    %visited.set("$row;$col");
    my @newstring = @string;
    my $current = @newstring.shift;

    for @directions -> $dir {
        my ($newRow, $newCol) = ($row, $col) Z+ @$dir;

        if $newRow ~~ 0 ..^ @grid.elems && $newCol ~~ 0 ..^ @grid[0].elems &&
        "$newRow;$newCol" ∉ %visited && @grid[$newRow;$newCol] eq $current {
            return traverse(@grid, @newstring, %visited, $newRow, $newCol);
        }
    }

    return False;
}

sub MAIN(
    $str,
    *@chars
) {
    my @string = $str.comb;
    my @grid;

    for @chars -> $row {
        @grid.push($row.comb);
    }
    my $found = False;
    my $current = @string.shift;

    for 0 ..^ @grid.elems -> $row {
        for 0 ..^ @grid[$row].elems -> $col {
            if @grid[$row;$col] eq $current {
                my %visited is SetHash[Str];
                if traverse(@grid, @string, %visited, $row, $col) {
                    $found = True;
                    last;
                }
            }
        }
    }

    say $found;
}