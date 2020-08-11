use v6;

constant %boxes = (
    "R" => { "w" => 1,  val => 1  },
    "B" => { "w" => 1,  val => 2  },
    "G" => { "w" => 2,  val => 2  },
    "Y" => { "w" => 12, val => 4  },
    "P" => { "w" => 4,  val => 10 },
);
sub MAIN (UInt $max-nb = 5) {
    my ($best, $max) = find-best %boxes.keys.combinations: 1..$max-nb;
    say "Max: $max; ", $best;
}
sub find-best (@candidates) {
    my @valid-candidates = gather for @candidates -> $cand {
        take [ $cand, $cand.map({ %boxes{$_}{'val'}}).sum ]
            if $cand.map({ %boxes{$_}{'w'}}).sum <= 15;
    }
    return  @valid-candidates.max({$_[1]});
}
