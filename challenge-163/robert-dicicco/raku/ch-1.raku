use v6;

# AUTHOR: Robert DiCicco
# DATE: 2-MAY-2022
# Challenge 163 Sum Bitwise Operator ( Raku )

my @n = [(1,2,3), (2,3,4)];
my $sum = 0;

for ( @n ) -> @arr {
  for @arr.combinations: 2 -> @x {
    $sum += @x[0] +& @x[1];
  }

  print "(" ~ @arr ~ ") = $sum\n";
  $sum = 0;
}
