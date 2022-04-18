#! /usr/bin/perl

use strict;
use warnings;

my %f;
my %r;
while (<>) {
  chomp;
  my $b=1;
  my $v=0;
  foreach my $l ('a'..'z') {
    if (index($_,$l)>=0) {
      $v |= $b;
    }
    $b <<= 1;
  }
  if (!exists $r{$v} || length($r{$v}) > length($_)) {
    $f{$_}=$v;
    $r{$v}=$_;
  }
}

my @w;
my $lt=(1<<26) - 1;
my @lu=(0);
while ($lu[-1] != $lt) {
  my $wn='';
  if (@w) {
    my $mode=0;
    my @sc;
    foreach my $wv (keys %r) {
      if (($wv & $lu[-1]) == 0) {
        if ($mode==0) {
          $mode=1;
          @sc=();
        }
        push @sc,$r{$wv};
      } elsif ($mode==0 && ($wv | $lu[-1]) != $lu[-1]) {
        push @sc,$r{$wv};
      }
    }
    if (scalar @sc == 0) {
      pop @w;
      pop @lu;
    } else {
      $wn=$sc[int(rand()*scalar @sc)];
    }
  } else {
    $wn=(keys %f)[int(rand() * scalar keys %f)];
  }
  if ($wn) {
    push @w,$wn;
    push @lu, $lu[-1] | $f{$wn};
  }
}

print join(' ',@w),"\n";
