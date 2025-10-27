#!/bin/env raku

unit sub MAIN(*@ints);

my ($cnt, @seen, @ans);
for @ints {
    when $_ > 0 { @seen.unshift($_); $cnt = 0; }
    when -1     { @ans.push(@seen[$cnt++] // -1); }
}
put @ans;
