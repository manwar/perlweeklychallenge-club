#!/bin/env raku

unit sub MAIN(Str:D $str);

with $str.comb -> @c {
    when +@c > 0 { @c[$_].print for +@c-1...0; }
    put '';
}
