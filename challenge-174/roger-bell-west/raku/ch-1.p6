#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(disarium(19),
          [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 89, 135, 175, 518, 598, 1306, 1676,
            2427, 2646798 ],
          'example 1');

sub disarium($ct) {
    my @o;
    my @pows;
    @pows.push([(1 xx 10)».List.flat]);
    my $c = 0;
    while (True) {
        my $disar = 0;
        if $c > 0 {
            my $ca = $c;
            my @cl;
            my $tx = 0;
            while ($ca > 0) {
                $tx++;
                @cl.push($ca % 10);
                $ca div= 10;
            }
            @cl = @cl.reverse;
            if ($tx >= @pows.elems) {
                for @pows.elems..$tx -> $power {
                    my @row;
                    for 0..9 -> $digit {
                        @row.push(@pows[$power-1][$digit] * $digit);
                    }
                    @pows.push(@row);
                }
            }
            for 0..@cl.end -> $i {
                $disar += @pows[$i+1][@cl[$i]];
            }
        }
        if ($disar == $c) {
            @o.push($c);
            if (@o.elems >= $ct) {
                last;
            }
        }
        $c++;
    }
    return @o;
}
