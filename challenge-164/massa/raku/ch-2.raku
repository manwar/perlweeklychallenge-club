use v6;
sub sum-square-digits(\i) is pure { i.comb.map(*²).sum }
sub is-happy(\i) {
  state %what-i-know-about = 0 => False, 1 => True;
  $_ = i;
  my %visited;
  loop {
    with %what-i-know-about{$_} { %what-i-know-about{%visited.keys} = $_ xx *; .return }
    when %visited               { %what-i-know-about{%visited.keys} = False xx *; return False }
    default                     { %visited{$_}++; $_ = sum-square-digits $_ }
  }
}
(^∞).grep(*.&is-happy)[^8].say
