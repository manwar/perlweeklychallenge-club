#! /usr/bin/perl6

use Test;

plan 2;

is(sparkline([0, 100]), "▁█", 'example 1');
is(sparkline([1, 2, 3, 4, 5, 6, 7, 8]), "▁▂▃▄▅▆▇█", 'example 2');

sub sparkline(@nn) {
    my @bar;
    for (0x2581..0x2588) -> $bc {
        @bar.push($bc.chr);
    }
    my $mn = min(@nn);
    my $mx = max(@nn);
    my $inscale = $mx - $mn;
    my $outscale = @bar.elems;
    return @nn.map({@bar[min(floor(($_-$mn) / $inscale * $outscale),
                             $outscale - 1)]}).join('');
}
