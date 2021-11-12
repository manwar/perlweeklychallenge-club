#!/usr/bin/raku

sub search(@board) {
    my $rowlast = @board.elems - 1;
    my $collast = @board[0].elems - 1;

    my @searched;
    for 0 .. $rowlast -> $row  {
        for 0 .. $colmlast-> $col {
            @searched[$row][$col] = @board[$row][$col];
        }
    }

    for 0 .. $rowlast -> $row  {
        for 0 .. $colmlast-> $col {
            if @board[$row][$col] == -1 {
                for $row - 1 .. $row + 1 -> $y {
                    for $col - 1 .. $col + 1 -> $x {
                        if $y < 0 || $y > $rowlast || $x < 0 || $x > $colmlast{
                            next;
                        }

                        if @board[$y][$x] != -1 {
                            @searched[$y][$x]++;
                        }
                    }
                }
            }
        }
    }

    return @searched;
}

sub output(@board) {
    for 0 ..^ @board.elems -> $row {
        for 0 ..^ @board[$row].elems -> $col {
            print (@board[$row][$col] == -1 ?? 'x' !! @board[$row][$col]), ' ';
        }
        print "\n";
    }
}

sub MAIN(
    Str $filename
) {
    my @board;

    for $filename.IO.lines -> $line {
        @board.push($line.split(q{ }).map({ $_ eq '*' ?? 0 !! -1; }));
    }
 
    @board ==> search() ==> output();
}