#!/usr/bin/env raku
use Test;

is replace-digits('a1c1e1'),   'abcdef';
is replace-digits('a1b2c3d4'), 'abbdcfdh';
is replace-digits('b2b'),      'bdb';
is replace-digits('a16z'),     'abgz';
is replace-digits('a16bzd7'),  'abgbzdk';

sub replace-digits($s)
{
    my ($head, $tail) = $s.split(/ <.alpha>+ $ /, :v);

    my @result = do for $head.split(/ <.digit>+ /, :v:skip-empty).batch(2)
    {
        my $char  = .head ~~ / <.alpha> $ /;
        .head ~ [~] .tail.comb.map({ chr($char.ord + $_) })
    }

    ([~] @result) ~ ($tail or Empty)
}
