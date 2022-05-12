#!/usr/bin/env raku

sub is-happy-proactive($num) {
  state %happy-cache;
  without %happy-cache{$num} {
    my @sequence-until-period <== $num, *.comb.map(* ** 2).sum ... *
      andthen [\,] $_
      andthen .toggle: !*.repeated
      andthen .tail;
    %happy-cache{$_} = * xx (.tail == 1) given @sequence-until-period;   
  }
  %happy-cache{$num}
}

(^Inf).grep: &is-happy-proactive
  andthen .head: 8
  andthen .join: ', '
  andthen .say; 