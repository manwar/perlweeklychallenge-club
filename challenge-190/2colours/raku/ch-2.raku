#!/usr/bin/env raku

#NOTE: disallowing leading zeros and completely empty input

subset Encoding of Str where /^ <[1..9]><[0..9]>* $/;

use experimental :cached;

sub nth-letter($n) { chr(ord('A') + $n - 1) }


proto decodings(@content) is cached {*}
multi decodings(() --> '') {}
multi decodings(('0', ) --> Empty) {}
multi decodings(($codepoint, )) { nth-letter $codepoint }
multi decodings(('0', $, **@) --> Empty) {}
multi decodings(($first, $next, **@rest)) {
  slip (nth-letter($first) <<~<< decodings(($next, |@rest))),
  slip (.&nth-letter <<~<< decodings(@rest) if $_ <= 26 given $first ~ $next)
}



sub MAIN(Encoding $s) {
  $s.comb.&decodings.sort.join(', ').say;
}