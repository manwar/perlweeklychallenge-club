#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(max);

my $s=0;
my @list=(2,3,4);
if (@ARGV) {
  @list=@ARGV;
}
foreach my $i (0..$#list-1) {
  foreach my $j ($i+1..$#list) {
    $s+=f($list[$i],$list[$j]);
  }
}
print "$s\n";

sub f {
  my @f=@_;
  my @g=map {[split '',sprintf('%b',$_)]} @f;
  my $r=max(map{scalar @{$_}} @g);
  foreach my $i (0..$#g) {
    unshift @{$g[$i]},((0) x ($r-scalar @{$g[$i]}));
  }
  my $d=0;
  map {$d+=($g[0][$_]==$g[1][$_])?0:1} (0..$r-1);
  return $d;
}
