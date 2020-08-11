use Test2::V0;


sub sum_factors {
  my $expansion = 1 x shift;
  my $sum = 1;
  $expansion =~ /^(..+) \g1+ $ (?{ $sum += length $1 }) ./xg;

  return $sum
}

is sum_factors(4), 3;
is sum_factors(220), 284;
is sum_factors(284), 220;


done_testing;
