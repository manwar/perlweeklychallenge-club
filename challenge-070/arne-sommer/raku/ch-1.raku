#! /usr/bin/env raku

subset PosInt of Int where * >= 1;

unit sub MAIN (:$S is copy = 'perlandraku',
               PosInt :$O = 4,
	       PosInt :$C where $C < $O && $C + $O <= $S.chars = 3,
	       :$v, :$verbose = $v);

for 1 .. $C -> $index
{
  say "swap $index: { $S.substr($index, 1) } <-> { $S.substr($index + $O, 1) } == $S" if $verbose;

  ($S.substr-rw($index,1), $S.substr-rw($index + $O,1) ) =
  ($S.substr($index + $O, 1), $S.substr($index, 1));
}

say $S;
