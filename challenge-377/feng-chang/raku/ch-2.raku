#!/bin/env raku

unit sub MAIN(*@strings);

put +@strings.combinations(2).grep(-> (\s1,\s2) {
    s1.starts-with(s2) && s1.ends-with(s2) ||
    s2.starts-with(s1) && s2.ends-with(s1)
});
