#!/usr/bin/env raku
use Test;

ok  valid-number("1");
nok valid-number("a");
nok valid-number(".");
nok valid-number("1.2e4.2");
ok  valid-number("-1.");
ok  valid-number("+1E-8");
ok  valid-number(".44");

sub valid-number($str)
{
    $str.subst(/\.$/, ~Empty).Num
}
