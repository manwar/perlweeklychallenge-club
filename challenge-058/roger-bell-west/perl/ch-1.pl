#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(max);

foreach my $vtest (
  ['0.1','1.1','-1'],
  ['2.0','1.2','1'],
  ['1.2','1.2_5','-1'],
  ['1.2.1','1.2_1','1'],
  ['1.2.1','1.2.1','0'],
    ) {
  my $vr=compare($vtest->[0],$vtest->[1]);
  print "$vtest->[0] $vtest->[1] $vtest->[2] $vr\n";
}

sub compare {
  my @v=@_;
  my @s;
  my %l=('_' => 1, '.' => 2);
  foreach my $i (0,1) {
    unless ($v[$i] =~ /^[0-9]+([._][0-9]+)*$/) {
      die "$v[$i] is not a valid version\n";
    }
    $s[$i]= [split /([._])/,$v[$i]];
    for (my $j=1;$j<=$#{$s[$i]};$j+=2) {
      $s[$i][$j]=$l{$s[$i][$j]};
    }
  }
  my $k=0;
  foreach my $j (0..max(map {$#{$_}} @s)) {
    $k=(($s[0][$j] || 0) <=> ($s[1][$j] || 0));
    if ($k != 0) {
      last;
    }
  }
  return $k;
}
