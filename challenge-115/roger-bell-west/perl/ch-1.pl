#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 5;

is(sc(qw(abc dea cd)),1,'example 1');
is(sc(qw(ade cbd fgh)),0,'example 2');
is(sc(qw(abc dea fgh hif)),0,'example 3');
is(sc(qw(abc dec cfa cgd)),1,'example 4');
is(sc(qw(abc def cd)),0,'example 5');

sub sc {
  my @n=@_;
  my @m;
  my %i;
  foreach my $t (@n) {
    push @m,substr($t,-1,1);
    push @{$i{substr($t,0,1)}},$#m;
  }
  my @chain=([0]);
  while (@chain) {
    my $stub=pop @chain;
    my %v=map {$_ => 1} (0..$#n);
    map {delete $v{$_}} @{$stub};
    if (%v) {
      if (exists $i{$m[$stub->[-1]]}) {
        my @x=grep {exists $v{$_}} @{$i{$m[$stub->[-1]]}};
        foreach my $x (@x) {
          push @chain,[@{$stub},$x];
        }
      }
    } else {
      if (exists $i{$m[$stub->[-1]]} && $i{$m[$stub->[-1]]}[0]==0) {
        return 1;
      }
    }
  }
  return 0;
}
