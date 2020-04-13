#! /usr/bin/perl6

my @N = (2, 7, 9);
my $k = 2;

my @out;
for (0..@N.end-1) -> $j {
  for ($j+1..@N.end) -> $i {
    if (@N[$i]-@N[$j] == $k) {
      push @out,($i,$j);
    }
  }
}

for @out -> @a {
  print "@a[0], @a[1]\n";
}
