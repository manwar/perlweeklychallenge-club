use v6;
unit sub MAIN(IntStr:D $m where * > 0, IntStr:D $n where * > 0) {
    my @m  = <1>...$m;
    my @n  = <1>...$n;
    my @mn = @m X* @n;

    my Int:D $nw = @n.map(*.chars).max;
    my Int:D $mw = @m.map(*.chars).max + 1;

    put sprintf '╭%-s┬%-s╮', '─' x $nw, '─'.&border('┬');
    put sprintf '│%-s│%-s│', '✕'.&col(' '), @n.&row('│');
    put sprintf '├%-s╆%-s┪', '─' x $nw, '━'.&border('┿');
    put sprintf '│%-s┃%-s┃', .head.&col(' '), .&row('│') for @mn.rotor($n);
    put sprintf '╰%-s┺%-s┛', '─' x $nw, '━'.&border('┷');
    put "Distinct Terms: $_" and
        put "Count: $_.:<+>" given @mn.unique.sort;

    sub border(Str:D $border, Str:D $delim --> Str:D) {
        join $delim, $border x $mw xx $n
    }
    sub col(Str:D(Cool:D) $col, Str:D $delim --> Str:D) {
        ($delim x ($nw - $col.chars)) ~ $col
    }
    sub row(@xs, Str:D $delim --> Str:D) {
        @xs.map(*.&cell: ' ').join($delim)
    }
    sub cell(Str:D(Cool:D) $cell, Str:D $delim --> Str:D) {
        ($delim x ($mw - $cell.chars)) ~ $cell
    }
}
