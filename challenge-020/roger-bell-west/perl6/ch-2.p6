#! /usr/bin/perl6

my $a=1;
while (1) {
  $a++;
  my @a=divisors_unself($a);
  my $b=@a.sum;
  if ($b <= $a) {
    next;
  }
  my @b=divisors_unself($b);
  my $aa=@b.sum;
  if ($aa == $a) {
    print "$a, $b\n";
  }
}

sub divisors_unself ($k) {
  my @d=(1);
  my @e;
  for 2..$k.sqrt.Int -> $d {
    if ($k % $d == 0) {
      push @d,$d,$k/$d;
      if @d[*-1] == $d {
        pop @d;
      }
    }
  }
  return @d;
}
