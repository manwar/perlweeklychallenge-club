#!/usr/bin/env raku
use Test;

say rank-score(<20 76 15 55 76 15 20 20 15 20 20>);

sub rank-score($list)
{
    my $b = $list.Bag;
    my @k = $b.keys.sort(-*);
    my @v = [\+] flat 1, $b{@k};

    @v[^3] .= map({ <Nil G S B>[$_] or $_ });
    my %h = @k Z=> @v;

    $list.map({ %h{$_} })
}
