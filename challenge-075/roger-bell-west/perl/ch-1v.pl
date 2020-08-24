#! /usr/bin/perl

use strict;
use warnings;
use List::Util qw(sum);

coinsum([1,2,4],6);

sub coinsum {
  my $c=shift;
  my @c=@{$c};
  my $s=shift;
  my @m;
  foreach (0..$#c) {
    push @m,int($s/$c[$_]);
  }
  my @out;
  my @b=(0) x scalar @c;
 OUTER:
  while (1) {
    my $v=sum(map {$c[$_]*$b[$_]} (0..$#c));
    if ($v==$s) {
      push @out,[@b];
    }
    my $i=0;
    while (1) {
      $b[$i]++;
      if ($b[$i]>$m[$i]) {
        $b[$i]=0;
        $i++;
        if ($i>$#b) {
          last OUTER;
        }
      } else {
        last;
      }
    }
  }
  my $o=scalar @out;
  if ($o==1) {
    print "There is 1 possible way to make sum $s.\n";
  } else {
    print "There are $o possible ways to make sum $s.\n";
  }
  my @index=('a'..'z');
  foreach my $li (0..$#out) {
    my @a;
    foreach my $i (0..$#{$out[$li]}) {
      push @a,($c[$i]) x $out[$li][$i];
    }
    print $index[$li].') ('.join(', ',@a).")\n";
  }
}
