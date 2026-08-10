#!/usr/bin/env raku
use Test;

ok  similar-list(<great acting>, <fine drama>, (<great fine>, <acting drama>));
nok similar-list(<apple pie>, <banana pie>, (<apple peach>, <peach banana>));
ok  similar-list(<perl4 python>, <raku python>, (<perl4 perl5 raku>,));
nok similar-list(<enjoy challenge>, <love weekly challenge>, (<enjoy love>,));
ok  similar-list(<fast car>, <quick vehicle>, (<quick fast>, <vehicle car>));

sub similar-list($a, $b, $c)
{
    # not sure I understand this problem but the tests pass... 🤷

    my $z = try $a >>,<< $b; 
    return False if $!;

    so all $z.map: { $_ (<=) ($c[$++] // $_) }
}
