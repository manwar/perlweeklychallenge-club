#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 4;

is_deeply(bs('abcdabcd'),['abcd','abcdabcd'],'bs-only 1');
is_deeply(bs('aaa'),['a','aaa'],'bs-only 2');

is_deeply(cbs('abcdabcd','abcdabcdabcdabcd'),['abcd','abcdabcd'],'example 1');
is_deeply(cbs('aaa','aa'),['a'],'example 2');

sub cbs {
  my @bss=map {bs($_)} @_;
  my %r;
  my $f=0;
  foreach my $bs (@bss) {
    if ($f) {
      my %s=map {$_ => 1} @{$bs};
      foreach my $k (keys %r) {
        unless (exists $s{$k}) {
          delete $r{$k};
        }
      }
    } else {
      %r=map {$_ => 1} @{$bs};
      $f=1;
    }
  }
  return [sort keys %r];
}

sub bs {
  my $str=shift;
  my $sl=length($str);
  my %f;
  foreach my $n (1..int(sqrt($sl))) {
    my $p=$sl/$n;
    if ($p==int($p)) {
      $f{$n}=$p;
      $f{$p}=$n;
    }
  }
  my @out;
  foreach my $l (sort keys %f) {
    my $q=substr($str,0,$l);
    if ($q x $f{$l} eq $str) {
      push @out,$q;
    }
  }
  return \@out;
}

