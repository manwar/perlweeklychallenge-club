#! /usr/bin/perl

use strict;

use Time::Local;

use Test::More tests => 3;

is_deeply(mirdat(
  [2021,9,18],[2021,9,22]
    ),
          [[2021,9,14],[2021,9,26]],
          'example 1'
            );

is_deeply(mirdat(
  [1975,10,10],[2021,9,22]
    ),
          [[1929,10,27],[2067,9,5]],
          'example 2'
            );

is_deeply(mirdat(
  [1967,2,14],[2021,9,22]
    ),
          [[1912,7,8],[2076,4,30]],
          'example 3'
            );

sub mirdat {
  my $then=shift;
  my $thent=ymd2ut($then);
  my $now=shift;
  if ($now->[0]==0) {
    $now=ut2ymd(time);
  }
  my $nowt=ymd2ut($now);
  my $delta=$nowt-$thent;
  my @o;
  foreach my $targett ($thent-$delta,$nowt+$delta) {
    push @o,ut2ymd($targett);
  }
  return \@o;
}

sub ymd2ut {
  my $ta=shift;
  my ($y,$m,$d)=@{$ta};
  return timegm(0,0,0,$d,$m-1,$y);
}

sub ut2ymd {
  my $ut=shift;
  my @t=localtime($ut);
  return [$t[5]+1900,$t[4]+1,$t[3]];
}
