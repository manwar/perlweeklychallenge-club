use v6;
unit sub MAIN(Int $n);
my sub esthetic-number(Int $n --> Bool) { $n.comb.rotor(2 => -1).map({1 == abs [-] $_}).all.Bool }
say esthetic-number $n
