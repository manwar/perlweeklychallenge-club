#!/usr/bin/env raku

sub cardano-sum($a, $b, $c) {
  ($a+$b*$c**0.5 andthen .sign*.abs**(1/3))+($a-$b*$c**0.5 andthen .sign*.abs**(1/3))
}


my $cardano-triplets = gather {
  for 1..Inf -> $biggest {
    for 1..$biggest -> $mid {
      for 1..$mid -> $smallest {
        .take if cardano-sum(|$_) =~= 1 for permutations(($biggest, $mid, $smallest));
      }
    }
  }
}
.join(" ").say for $cardano-triplets.head(5);
