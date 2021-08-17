#!/usr/bin/env raku

#| rows, columns, percent of mines
sub MAIN($r, $c, $p)
{
    my $n = $r * $c;
    my $mines = ($p / 100 * $n).floor;
    my @m = ('*' x $n - $mines ~ 'x' x $mines).comb
                                              .pick($n)
                                              .rotor($c)
                                              .map(*.Array);

    .say for @m;
     say ' ';
    .say for minesweeper(@m);
}

sub minesweeper(@m)
{
    my $rows = + @m;
    my $cols = + @m.head;

    for ^$rows X ^$cols -> ($r, $c)
    {
        next if @m[$r;$c] eq 'x';

        @m[$r;$c] = + .comb('x') given gather
        {
            take @m[$r-1;$c]   // '*'; # N
            take @m[$r-1;$c+1] // '*'; # NE
            take @m[$r;$c+1]   // '*'; # E
            take @m[$r+1;$c+1] // '*'; # SE
            take @m[$r+1;$c]   // '*'; # S
            take @m[$r+1;$c-1] // '*'; # SW
            take @m[$r;$c-1]   // '*'; # W
            take @m[$r-1;$c-1] // '*'; # NW
        }
    }

    @m
}
