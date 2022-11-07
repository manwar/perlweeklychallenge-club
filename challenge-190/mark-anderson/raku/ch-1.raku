#!/usr/bin/env raku
use Test;

ok  capital-detection("Perl");
ok  capital-detection("TPF");
nok capital-detection("PyThon");
ok  capital-detection("raku");

sub capital-detection($s)
{
    any($s eq $s.tclc, $s eq $s.lc, $s eq $s.uc)
}
