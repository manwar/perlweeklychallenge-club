#! /usr/bin/perl6

em(13,238);

sub em($aa,$bb) {
  my ($a,$b)=($aa,$bb);
  my $s=0;
  my @demo;
  while ($a > 0) {
    my $line=sprintf('%5d %5d',$a,$b);
    if ($a +& 1 == 1) {
      $s+=$b;
      $line ~= sprintf(' -> %5d',$b);
    }
    $a +>= 1;
    $b +<= 1;
    push @demo,$line;
  }
  push @demo,'               -----';
  push @demo,sprintf('               %5d',$s);
  for @demo {
    say $_;
  }
  return $s;
}
