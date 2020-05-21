use v6;

say @*ARGS.rotor(2 => -1).max({$_[0] * $_[1]});
