#! /usr/bin/perl6

my $N = 2;
my $S = 4;

my @out;

my @l;

repeat {
  my @n=(0,);
  if (@l) {
    @n=(shift @l).flat;
  }
  my $s=pop @n;
  if (@n.elems == $N-1) {
    my $digit=$S-$s;
    if ($digit>=0 && $digit <= 9) {
      push @out,join('',@n,$digit);
    }
  } else {
    for (($s==0 ?? 1 !! 0)..min($S-$s,9)) -> $digit {
      push @l,(map {$_},@n,$digit,$s+$digit);
    }
  }
} while (@l);

say join(', ',sort @out);
