#!/usr/bin/env raku
use Test;

ok  acronyms(<Perl Weekly Challenge>, "PWC");
ok  acronyms(<Bob Charlie Joe>, "BCJ");
nok acronyms(<Morning Good>, "MM");

sub acronyms(@array, $word)
{
    ([~] @array>>.substr(0,1)) eq $word
}
