#!/usr/bin/env raku

=begin comment

Input from STDIN. Board in 2D 9x9 grid.
Empty cells should be filled with "_".

    # board.txt
    [ _ 2 3 _ 6 8 9 _ _ ]
    [ _ 7 5 _ 3 _ _ 2 _ ]
    [ 9 _ 6 _ 1 _ _ _ _ ]
    [ 6 _ _ 1 _ 5 2 _ _ ]
    [ _ 3 _ 6 _ 2 _ 5 _ ]
    [ _ _ 2 7 _ 3 _ _ 1 ]
    [ _ _ _ _ 5 _ 6 _ 7 ]
    [ _ 5 _ _ 2 _ 8 1 _ ]
    [ _ _ 8 9 7 _ 5 4 _ ]

    sudoku-soluciotns.raku < board.txt

=end comment

sub MAIN() {
    my @board = read-board();
    show(@board);
    solve-recursive(@board);
}

sub read-board {
    my @board;
    for $*IN.lines -> $line {
        my @row = $line.subst(/_/, "0", :g).comb(/\d/);
        @board.push(@row);
    }
    (@board.elems == 9 && @board[0].elems == 9) or die "Not a 9x9 board";
    return @board;
}

sub show(@board) {
    @board.map({ "[" ~ .join(" ") ~ "]" }).join("\n").say;
    say "";
}

sub possible(@board, $r, $c, $n) {
    my @row = @board[$r][*];
    return False if @row.any == $n;

    my @col = (^9).map({ @board[$_][$c] });
    return False if @col.any == $n;

    my $r0 = $r div 3 * 3;
    my $c0 = $c div 3 * 3;
    my @square = ((0,1,2) X (0,1,2)).map({ @board[ $r0 + $_[0] ][ $c0 + $_[1] ] });
    return False if @square.any == $n;

    return True;
}

sub solve-recursive(@board) {
    my ($r,$c) = ((^9) X (^9)).first(-> [$r,$c] { @board[$r][$c] == 0 });
    unless (defined($r) && defined($c)) {
        show(@board);
        return;
    }
    for (1..9).grep({ possible(@board, $r, $c, $^n) }) -> $n {
        @board[$r][$c] = $n;
        solve-recursive(@board);
        @board[$r][$c] = 0;
    }
}
