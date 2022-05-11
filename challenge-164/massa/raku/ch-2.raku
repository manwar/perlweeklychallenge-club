use v6;
sub sum-square-digits(\i) { i.comb.map(*²).sum }
sub is-happy(\i) {
  state %knowingly-sad;
  my %visited;
  $_ = i;
  loop {
    when 1              { return True }
    when %knowingly-sad { return False }
    when %visited       { last }
    default             { %visited{$_} = True; $_ = sum-square-digits $_ }
  }
  %knowingly-sad{%visited.keys}»++;
  False
}
(^∞).grep(*.&is-happy)[^8].say
