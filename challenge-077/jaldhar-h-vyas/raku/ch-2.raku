#!/usr/bin/raku

sub makeGrid(@args) {
    my @grid;

    for @args -> $row {
        @grid.push($row.comb.Array);
    }

    @grid.unshift(('O' xx @grid[0].elems).Array);
    @grid.push(('O' xx @grid[0].elems).Array);

    for @grid -> $row {
        $row.unshift('O');
        $row.push('O');
    }

    return @grid;
}

sub findLonely(@grid) {
    my $lonely = 0;

    for 0 ^..^ @grid.end -> $i {
        for 0 ^..^ @grid[$i].end -> $j {

            if @grid[$i][$j] eq 'X' {
                my $neighbors = 0;
                for -1 .. 1 -> $ii {
                    for -1 .. 1 -> $jj {
                        if @grid[$i + $ii][$j + $jj] ne 'X' {
                            $neighbors++;
                        }
                    }
                }

                if $neighbors == 8 {
                    $lonely++;
                }
            }
        }
    }

    return $lonely;
}

sub MAIN(
    *@args
) {
    say findLonely(makeGrid(@args));
}

