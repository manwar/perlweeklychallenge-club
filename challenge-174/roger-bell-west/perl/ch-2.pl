#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 4;

is(permutation2rank([1,0,2]),2,'example 1');

is_deeply(rank2permutation([0,1,2],1),[0,2,1],'example 2');

is(permutation2rank([2,0,3,1]),13,'example 3');

is_deeply(rank2permutation([1,3,2,0],7),[1,0,3,2],'example 4');

sub permutation2rank($perm) {
  my @perm = @{$perm};
  my $n = 0;
  my @pp = sort { $a <=> $b } @perm;
  my @oi;
  my $l = 1;
  foreach my $index (2..scalar @perm) {
    push @oi, $l;
    $l *= $index;
  }
  @oi = reverse @oi;
  foreach my $index (0..$#perm-1) {
    my %base;
    foreach my $i (0..$#pp) {
      $base{$pp[$i]} = $i;
    }
    $n += $oi[$index] * $base{$perm[$index]};
    delete $base{$perm[$index]};
    @pp = sort { $a <=> $b } keys %base;
  }
  return $n;
}

sub rank2permutation($perm, $rank0) {
  my @perm = @{$perm};
  my $rank = $rank0;
  my @pp = sort { $a <=> $b } @perm;
  my @o;
  my @oi;
  my $l = 1;
  foreach my $index (2..scalar @perm) {
    push @oi, $l;
    $l *= $index;
  }
  @oi = reverse @oi;
  foreach my $index (0..$#perm-1) {
    my $ix = int($rank / $oi[$index]);
    push @o,$pp[$ix];
    @pp = grep {$_ != $pp[$ix]} @pp;
    $rank %= $oi[$index];
  }
  push @o,$pp[0];
  return \@o;
}
