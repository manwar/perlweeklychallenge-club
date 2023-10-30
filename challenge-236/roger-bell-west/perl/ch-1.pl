#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(exactchange([5, 5, 5, 10, 20]), 1, 'example 1');
is(exactchange([5, 5, 10, 10, 20]), 0, 'example 2');
is(exactchange([5, 5, 5, 20]), 1, 'example 3');

sub exactchange($a) {
  my $reserve = Reserve->new([5, 10, 20]);
  foreach my $tendered (@{$a}) {
    unless ($reserve->makechange(5, [$tendered])) {
      return 0;
    }
  }
  return 1;
}

package Reserve;

sub new($class, $init) {
  my $self = {
    vall => [sort {$b <=> $a} @{$init}],
    counts => [(0) x scalar @{$init}],
  };
  bless $self, $class;
  my %vm;
  foreach my $n (0..$#{$self->{vall}}) {
    $vm{$self->{vall}[$n]} = $n;
  }
  $self->{vm} = \%vm;
  return $self;
}

sub makechange($self, $price, $tendered) {
  my $val = 0;
  foreach my $note (@{$tendered}) {
    unless (exists $self->{vm}{$note}) {
      return 0;
    }
    $self->{counts}[$self->{vm}{$note}]++;
    $val += $note;
  }
  if ($val < $price) {
    return 0;
  }
  $val -= $price;
  foreach my $bid (0..$#{$self->{vall}}) {
    while ($val >= $self->{vall}[$bid] && $self->{counts}[$bid] > 0) {
      $val -= $self->{vall}[$bid];
      $self->{counts}[$bid]--;
    }
  }
  return ($val == 0);
}
