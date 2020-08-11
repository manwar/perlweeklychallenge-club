#! /usr/bin/perl6

my $y=2019;

for (1..12) -> $m {
  my $mm=$m+1;
  my $yy=$y;
  if ($mm>12) {
    $mm-=12;
    $yy++;
  }
  my $d=Date.new($yy,$mm,1).earlier(:1day);
  my $wd=20;
  while ($d.day>28) {
    if ($d.day-of-week < 6) {
      $wd++;
    }
    $d=$d.earlier(:1day);
  }
  say "$m: $wd days";
}
