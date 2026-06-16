#!/usr/bin/env raku
use Test;

ok  sow(<acb cba cdb>);
ok  sow(<aab aac ad>);
nok sow(<bc je jg>);
ok  sow(<a aaaa aa>);
nok sow(<c d h>);

sub sow($list)
{
    my ($s1, $s2, $s3) = $list>>.trans("a".."j" => 0..9);
    $s1 + $s2 == $s3
}
