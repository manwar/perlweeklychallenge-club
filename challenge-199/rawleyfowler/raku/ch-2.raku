use v6;
sub MAIN($lst, $x, $y, $z) {
  my @lst = $lst.split(/\s/) || die 'Bad list passed';
  my $n = @lst.elems - 1;
  my $count = 0;
  for 0..$n -> $i {
    for ($i+1)..$n -> $j {
      for ($j+1)..$n -> $k {
        if abs(@lst[$i] - @lst[$j]) <= $x &&
           abs(@lst[$j] - @lst[$k]) <= $y &&
           abs(@lst[$i] - @lst[$k]) <= $z { $count++ }
      }
    }
  }
  say $count;
}
