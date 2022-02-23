use v6;

# Author: Robert DiCicco
# Date:   21-FEB-2022
# Challenge #153 Factorions ( Raku )

multi sub factorial($x where {$x < 2}) {
  return 1;
}

multi sub factorial($x where {$x >= 2}) {
  return $x * factorial($x - 1);
}

sub is_factorion(Int $n) {
  my $outstr = q{};
  my $sumdigits = 0;
  my @digits = $n.comb;

  for @digits -> $item {
    $outstr ~= "$item\! + ";
    $sumdigits += factorial($item);
  }

  print "$outstr.chop(3)" ~ " = $sumdigits\n";

  ($sumdigits == $n) ?? 1 !! 0;
}

sub MAIN(Int $num) {
  print "Input \$n = $num\n";

  my $ret = is_factorion($num);

  print "Output: $ret\n";
}
