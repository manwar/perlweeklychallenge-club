#! /usr/bin/perl6

use MONKEY-SEE-NO-EVAL;

my @base=(1..9);

my @sv=('','-','+');

my $maxdepth=8;
my @si=0 xx $maxdepth;

while (1) {
  my $str=join('',map {@base[$_] ~ @sv[@si[$_]]}, (0..^$maxdepth)) ~ @base[$maxdepth];
  my $tot=EVAL($str);
  if ($tot == 100) {
    print "$str\n";
  }
  my $i=0;
  while ($i < $maxdepth) {
    @si[$i]++;
    if (@si[$i] <= @sv.end) {
      last;
    }
    @si[$i]=0;
    $i++;
  }
  if ($i >= $maxdepth) {
    last;
  }
}
