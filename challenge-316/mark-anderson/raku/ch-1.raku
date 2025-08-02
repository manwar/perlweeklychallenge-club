#!/usr/bin/env raku
use Test;

ok  circular(<perl loves scala>);
nok circular(<love the programming>);
ok  circular(<java awk kotlin node.js>);

sub circular(@list)
{
    quietly not ~@list.match: / (\w) \s (\w) <?{ $0 ne $1 }> /
}
