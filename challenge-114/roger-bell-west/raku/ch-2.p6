#! /usr/bin/perl6

use Test;

plan 2;

is(hisb(3),5,'example 1');
is(hisb(12),17,'example 2');

sub hisb($n) {
  my $s='0' ~ sprintf('%b',$n);
  $s ~~ /^(.*?)01(1*0*)$/;
  my ($a,$c)=($0,$1);
  (my $t0=$c) ~~ s:g/1+//;
  (my $t1=$c) ~~ s:g/0+//;
  return ($a ~ '10' ~ $t0 ~ $t1).parse-base(2);
}
