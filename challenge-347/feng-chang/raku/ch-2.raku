#!/bin/env raku

unit sub MAIN(Str:D $s);

my @s = $s.comb(/\d/);
print(|@s.splice(0,3), '-') while +@s > 4;
put do given +@s {
    when 2|3 { @s.join }
    when 4   { sprintf '%s%s-%s%s', |@s }
}
