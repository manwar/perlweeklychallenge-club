use v6;
unit sub MAIN(Str:D $s);
say bag($s.comb).kv.map({ $s.index: $^k if $^v == 1 }).min;
