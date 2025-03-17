#!/usr/bin/env raku
use Test;

ok  broken-keys("perl", "perrrl");
ok  broken-keys("raku", "rrakuuuu");
nok broken-keys("python", "perl");
ok  broken-keys("coffeescript", "cofffeescccript");

sub broken-keys($name, $typed)
{
    $typed ~~ / <{ $name.comb.join("+") }> /
}
