#!/usr/bin/env raku
use Test;

nok rat-nums("0.(12)",    "0.(121)");
ok  rat-nums("0.1(23)",   "0.12(32)");
ok  rat-nums("0.1(234)",  "0.12(342)");
ok  rat-nums("12.99(99)", "13.");
ok  rat-nums("0.(123)",   "0.1(231)");

sub rat-nums($r1, $r2)
{
    sub convert($r)
    {
        $r.subst(/ '.' $ /)
          .subst(/ ('.' [<digit>+]?) '(' (<digit>+) ')' $ /, 
                                      { ($0 ~ $1 x 15).substr(0,16) })
    }
 
    convert($r1) =~= convert($r2)
}
