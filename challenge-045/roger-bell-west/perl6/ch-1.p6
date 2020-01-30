#! /usr/bin/perl6

my $n=8;

my $in='';

for lines() {
  .chomp;
  my $t=$_;
  $t ~~ s:g/\s+//;
  $in~=$t;
}

my $l=chars($in)-1;
my @out;
for (0..$n-1) -> $c {
  my $out;
  my $k=$c;
  while ($k <= $l) {
    $out~=substr($in,$k,1);
    $k+=$n;
  }
  push @out,$out;
}

say @out.join(' ');