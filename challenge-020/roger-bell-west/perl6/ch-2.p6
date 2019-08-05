#! /usr/bin/perl6

my $a=1;
while (1) {
  $a++;
  my @a=divisors_unself($a);
  unless (@a) {
    next;
  }
  my $b=@a.sum;
  if ($b <= $a) {
    next;
  }
  my @b=divisors_unself($b);
  unless (@b) {
    next;
  }
  my $aa=@b.sum;
  if ($aa == $a) {
    print "$a, $b\n";
  }
}

sub divisors_unself ($k) {
  my @d=(1);
  for 2..$k/2.Int -> $d {
    if ($k % $d == 0) {
      push @d,$d;
    }
  }
  return @d;
}