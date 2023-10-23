#!/usr/bin/env raku
use Test;

ok  acronym(<Perl Python Pascal>, 'ppp');
nok acronym(<Perl Raku>,           'rp');
ok  acronym(<Oracle Awk C>,       'oac');

sub acronym(@a, $ck)  
{
    so all map { .[0].starts-with(.[1].uc) }, (@a Z $ck.comb) 
}
