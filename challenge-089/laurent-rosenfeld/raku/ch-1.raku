use v6;

say (1..$_).combinations(2).map({$_[0] gcd $_[1]}).sum for 1..1..@*ARGS[0];
