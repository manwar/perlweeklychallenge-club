#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);
use Storable qw(dclone);
use Data::Dumper::OneLine;

# Input
my @S = ([1, 2], [6, 7], [8, 10]);
my @N = (4, 5);

# Insert Interval
my $len = scalar @S;

## In the beginning
if($N[1] < $S[0][0]) {
  unshift @S, \@N;
  say Dumper(\@S);
  exit;
}

## In the end
if($N[0] > $S[$len - 1][1]) {
  push @S, \@N;
  say Dumper(\@S);
  exit;
}

## In the middle
my @res = ();
my $one = undef;
my $added = 0;

for(my $i = 0; $i < $len; $i++) {
  my ($fst, $snd) = @{$S[$i]};

  $added = add($N[0], $N[1]) if(!defined $one && $N[0] < $fst && $N[1] < $snd && $added == 0);
  $one = $N[0] if(!defined $one && $N[0] < $fst && $N[1] >= $fst);
  $one = $fst if(!defined $one);

  if($N[0] <= $snd && $N[1] > $snd) {
    $added = add($one, $N[1]) if(!defined $S[$i + 1] || $S[$i + 1][0] > $N[1]);
  } else {
    add($one, $snd);
  }
}

# Output
say Dumper(\@res);

# Add pair
sub add {
  push @res, \@{dclone(\@_)};
  $one = undef;
  return 1;
}