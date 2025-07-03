
sub f {
  local $_ = shift;
  #idea: using negative lookbehind and negative lookahead replace ? one at a time with a, b or c until no more ? is replaced:
  1 while
    s/ (?<!a) \? (?!a) /a/x  or #if ? neighter has a behind nor ahead, then replace it with a
    s/ (?<!b) \? (?!b) /b/x  or #if ? neighter has b behind nor ahead, then replace it with b
    s/ (?<!c) \? (?!c) /c/x;    #if ? neighter has c behind nor ahead, then replace it with c
  $_
}

print f("a?z")     eq "abz"      ? "ok\n" : "err\n";
print f("pe?k")    eq "peak"     ? "ok\n" : "err\n";
print f("gra?te")  eq "grabte"   ? "ok\n" : "err\n";
print f("a?????b") eq "ababacb"  ? "ok\n" : "err\n";
print f("?a?")     eq "bab"      ? "ok\n" : "err\n";
print f("?b")      eq "ab"       ? "ok\n" : "err\n";
print f("b???a?")  eq "babcab"   ? "ok\n" : "err\n";
print f("?")       eq "a"        ? "ok\n" : "err\n";
