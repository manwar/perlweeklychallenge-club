#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

open my $fh, '<', 'grid.txt';
my @G;
(chomp, push @G, [ split ]) while(<$fh>);
close $fh;
my @lines = map { join '', @{$_} } @G;
foreach my $i ( 0..@{$G[0]}-1 ) {
  push @lines, join '', map { $_->[$i] } @G;
}
my $size = @G > @{$G[0]} ? @G : @{$G[0]};
foreach my $i ( 0..$size-1 ) {
  unless($i >= @G) {
    unless( $i >= @{$G[0]} ) {
      push @lines, join '', map { $G[$i][$i+$_] } 0..$size-$i-1;
    }
    push @lines, join '', map { $G[$i][$i-$_] } 0..$i;
  }
  unless($i >= @{$G[0]}) {
    unless( $i >= @G ) {
      push @lines, join '', map { $G[$i+$_][$i] } 0..$size-$i-1;
    }
    push @lines, join '', map { $G[$i-$_][$i] } 0..$i;
  }
}
push @lines, map { reverse $_ } @lines;
say for @lines;

sub my_function {
  return 1;
}

