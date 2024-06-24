#!/usr/bin/env raku
use Test;

is replace-digits('a1c1e1'),   'abcdef';
is replace-digits('a1b2c3d4'), 'abbdcfdh';
is replace-digits('b2b'),      'bdb';
is replace-digits('a16z'),     'abgz';
is replace-digits('a16bzd7'),  'abgdk';

sub replace-digits($s)
{
    my ($head, $tail) = $s.split(/ <.alpha>+ $ /, :v);

    my @result = do for $head.split(/\d+/, :v:skip-empty).batch(2)
    {
        my $char  = .head ~~ / <.alpha> $ /;
        $char ~ [~] .tail.comb.map({ chr($char.ord + $_) })
    }

    ([~] @result) ~ ($tail or Empty)
}
