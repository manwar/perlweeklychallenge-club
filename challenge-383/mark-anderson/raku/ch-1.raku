#!/usr/bin/env raku
use Test;

ok  similar-list(<great acting>, <fine drama>, (<great fine>, <acting drama>));
nok similar-list(<apple pie>, <banana pie>, (<apple peach>, <peach banana>));
ok  similar-list(<perl raku>, <perl python>, Empty);
nok similar-list(<enjoy challenge>, <love weekly challenge>, (<enjoy love>));
ok  similar-list(<fast car>, <quick vehicle>, (<quick fast>, <vehicle car>));

sub similar-list($a, $b, $c)
{
    so all ([Z] $a, $b).map: { ($_ (+) ($c[$++] // Empty)).Set (==) $_ }
}
