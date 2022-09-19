use v6;
unit sub MAIN(Int:D $i, **@n where .are ~~ Numeric);
say cache @n.grep: not * <= $i;
