#! /usr/bin/perl6

use Test;

plan 4;

is-deeply(bs('abcdabcd'),['abcd','abcdabcd'],'bs-only 1');
is-deeply(bs('aaa'),['a','aaa'],'bs-only 2');

is-deeply(cbs('abcdabcd','abcdabcdabcdabcd'),('abcd','abcdabcd'),'example 1');
is-deeply(cbs('aaa','aa'),('a',),'example 2');

sub cbs(**@strs) {
  my @bss=map {bs($_)},@strs;
  my $r=SetHash.new;
  my $f=0;
  for @bss -> @bs {
    if ($f) {
      my $s=@bs.SetHash;
      $r = $r (&) $s;
    } else {
      $r=@bs;
      $f=1;
    }
  }
  return sort $r.keys;
}

sub bs($str) {
  my $sl=$str.chars;
  my %f;
  for 1..floor(sqrt($sl)) -> $n {
    my $p=$sl/$n;
    if ($p==floor($p)) {
      %f{$n}=$p;
      %f{$p}=$n;
    }
  }
  my @out;
  for sort keys %f -> $l {
    my $q=substr($str,0,$l);
    if ($q x %f{$l} eq $str) {
      push @out,$q;
    }
  }
  return @out;
}

