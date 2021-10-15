use v6;
unit sub MAIN(IntStr:D $m where * > 0, IntStr:D $n where * > 0) {
    my @m  = <1>...$m;
    my @n  = <1>...$n;
    my @mn = @m X* @n;

    my Int:D $nw = @n.map(*.chars).max + 1;
    my Int:D $cw = @m.map(*.chars).max + 1;
    my Int:D $mw = @mn.map(*.chars).max + 1;

    put sprintf '╭%-s┬%-s╮', '─' x $nw, border('─', '┬');
    put sprintf '│%-s│%-s│', ' ' x ($nw - 1) ~ '✕', fmt-row(@n, '│');
    put sprintf '├%-s╆%-s┪', '─' x $nw, border('━', '┿');
    put sprintf '│%-s┃%-s┃', fmt-cell($_.head), fmt-row($_, '│') for @mn.rotor($n);
    put sprintf '╰%-s┺%-s┛', '─' x $nw, border('━', '┷');
    put "Distinct Terms: $_" and
        put "Count: $_.:<+>" given @mn.unique.sort;

    sub border(Str:D $token, Str:D $delim) {
        join $delim, $token x $cw xx $n
    }
    sub fmt-row(@xs, Str:D $delim) {
        @xs.map(&fmt-cell).join($delim)
    }
    sub fmt-cell(Int:D $mn) {
        (' ' x $cw).chop($mn.chars) ~ $mn
    }
}
