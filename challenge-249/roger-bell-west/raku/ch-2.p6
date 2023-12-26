#! /usr/bin/raku

use Test;

plan 3;

is-deeply(distringmatch('IDID'), [0, 4, 1, 3, 2], 'example 1');
is-deeply(distringmatch('III'), [0, 1, 2, 3], 'example 2');
is-deeply(distringmatch('DDI'), [3, 2, 0, 1], 'example 3');

sub distringmatch($a) {
    my $v = 1 +< ($a.chars - 1);
    my $wv = $v +< 1;
    my @out = [$wv];
    for $a.comb -> $c {
        if ($c eq 'I') {
            $wv += $v
        } else {
            $wv -= $v;
        }
        $v +>= 1;
        @out.push($wv);
    }
    my @r = @out.sort({$^a <=> $^b});
    my %c = (0..@r.end).map({@r[$_] => $_});
    return @out.map({%c{$_}}).Array;
}
