#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(fivenumber([0.0, 0.0, 1.0, 2.0, 63.0, 61.0, 27.0, 13.0]),
          [0.0, 0.5, 7.5, 44.0, 63.0],
          'example 1');

sub fivenumber(@n0) {
    my @n = @n0.sort();
    my $nl = @n.elems - 1;
    my @o = [@n[0]];
    for (1..3) -> $quartile {
        my $bx = $quartile * $nl;
        my $base = $bx div 4;
        my $v = @n[$base];
        if ($bx % 4 != 0) {
            $v = (@n[$base] + @n[$base+1]) / 2
        }
        @o.push($v);
    }
    @o.push(@n.tail);
    return @o;
}
