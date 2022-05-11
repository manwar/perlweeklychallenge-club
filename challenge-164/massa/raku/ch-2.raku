use v6;
sub sum-square-digits(\i) is pure { i.comb.map(*²).sum }
sub is-happy($_ is copy) {
  state %happiness = 0 => False, 1 => True;
  loop (my %visited;; $_ = sum-square-digits $_) {
    with %happiness{$_} { %happiness{%visited.keys} = $_ xx *; .return }
    when %visited       { %happiness{%visited.keys} = False xx *; return False }
    default             { %visited{$_}++ }
  }
}
(^∞).grep(*.&is-happy)[^8].say
