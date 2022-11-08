#!/usr/bin/env raku
use Test;

ok  capital-detection("Perl");
ok  capital-detection("TPF");
nok capital-detection("PyThon");
ok  capital-detection("raku");

sub capital-detection($s)
{
    $s eq any($s.tclc, $s.lc, $s.uc)
}
