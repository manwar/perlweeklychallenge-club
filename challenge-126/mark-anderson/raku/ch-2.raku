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
    for ^@m X ^@m.head -> ($r, $c)
    {
        next if @m[$r;$c] eq 'x';

        @m[$r;$c] = + .comb('x') given gather
        {
            for [-1, 0, 1] X [-1, 0, 1] -> ($a, $b)
            {
                take @m[$r+$a;$c+$b] || '*';
            }
        }
    }

    @m
}
