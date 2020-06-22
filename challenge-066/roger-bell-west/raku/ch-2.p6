#! /usr/bin/perl6

use Test;

plan 3;

is(singlefactor(9),'3^2','nine');
is(singlefactor(45),'0','forty-five');
is(singlefactor(36),'6^2','thirty-six');

sub singlefactor(Int $in0) {
  my $in=$in0;
  my $factor=2;
  my %pf;
  while (1) {
    my $p=0;
    while ($in % $factor == 0) {
      $in/=$factor;
      $p++;
    }
    if ($p>0) {
      %pf{$factor}=$p;
    }
    if ($in < 2) {
      last;
    }
    if ($factor==2) {
      $factor++;
    } else {
      repeat {
        $factor+=2;
      } until is-prime($factor);
    }
  }
  if (max(values %pf) == min(values %pf)) {
    my $f=1;
    for keys %pf {
      $f*=$_;
    }
    return $f ~ '^' ~ min(values %pf);
  } else {
    return '0';
  }
}
