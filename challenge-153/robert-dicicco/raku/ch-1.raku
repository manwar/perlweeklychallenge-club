use v6;

# Author: Robert DiCicco
# Date:   21-FEB-2022
# Challenge #153 Left Factorial ( Raku )

multi sub factorial(Int $x where {$x < 2}) {
  return 1;
}

multi sub factorial(Int $x where {$x >= 2}) {
  return $x * factorial($x - 1);
}

my $prevval = 0;
print 'Left Factorials: ';

for 0..9 -> $i {
  my $val = factorial($i);
  $prevval += $val;
  print "$prevval ";
}

print "\n";
