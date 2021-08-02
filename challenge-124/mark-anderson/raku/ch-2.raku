#!/usr/bin/env raku

say tug-of-war(10, 20 ... 100);
say tug-of-war(10, -15, 20, 30, -25, 0, 5, 40, -5);

sub tug-of-war(+$list)
{
    my %h = $list.combinations(+$list div 2).map(-> $a
    {
        my $b = ($list (-) $a).keys.List;
        abs($b.sum - $a.sum) => ($a, $b);
    });

    %h.min.value;
}
