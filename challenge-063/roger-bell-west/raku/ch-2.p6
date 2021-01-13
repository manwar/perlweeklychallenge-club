#! /usr/bin/perl6

if (rotate('xyxx') != 7) {
  die "wrong answer";
}

sub rotate ($str) {
  my @s=$str.comb(/./);
  my $k=@s.elems;
  my $n=0;
  while (1) {
    $n++;
    my @l=splice @s,0,($n % $k);
    map {push @s,$_},@l.flat;
    if (join('',@s) eq $str) {
      last;
    }
  }
  return $n;
}
