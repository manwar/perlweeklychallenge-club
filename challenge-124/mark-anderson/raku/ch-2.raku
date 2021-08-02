#!/usr/bin/env raku

say tug-of-war(10, 20 ... 100);
say tug-of-war(10, -15, 20, 30, -25, 0, 5, 40, -5);

sub tug-of-war(+$list)
{
    my $n = $list.elems div 2;

    my %h = $list.combinations($n).map(-> @a
    {
        my @b = ($list (-) @a).keys;

        abs(@b.sum - @a.sum) => @a ~ ' ' ~ @b;
    });

    .head($n), .tail(* - $n) with %h.min.value.split(/\s/).cache;
}
