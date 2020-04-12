#! /usr/bin/perl

use strict;
use warnings;

use integer;

my ($n,$k)=@ARGV;

my @f;
my $b=1;
my $v=1;
while ((scalar @f == 0) || $f[-1] < $k) {
  push @f,$v;
  $v*=$b;
  $b++;
}

my $nk=$k-1;
my @n;
for (my $i=$#f;$i>=0;$i--) {
  unshift @n,$nk/$f[$i];
  $nk-=$f[$i]*$n[0];
}

my @i=(1..$n);
my @o;
for (my $i=$n;$i>=1;$i--) {
  my $f=$n[$i-1] || 0;
  push @o,splice @i,$f,1;
}

print join($n>9?',':'',@o),"\n";
