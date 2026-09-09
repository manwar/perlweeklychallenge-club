#!/bin/env raku

unit sub MAIN(*@strs);

while @strs.any.match('?') {
    with @strs.first(/'?'/, :k) -> $i {
        @strs.splice($i, 1, @strs[$i].subst(/'?'/, '0'), @strs[$i].subst(/'?'/, '1'));
    }
}
put @strs.join(',');
