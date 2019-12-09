#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(shuffle sum);

my $l=7;

my %tilecount=(
  A => 8,
  G => 3,
  I => 5,
  S => 7,
  U => 5,
  X => 2,
  Z => 5,
  E => 9,
  J => 3,
  L => 3,
  R => 3,
  V => 3,
  Y => 5,
  F => 3,
  D => 3,
  P => 5,
  W => 5,
  B => 5,
  N => 4,
  T => 5,
  O => 3,
  H => 3,
  M => 4,
  C => 4,
  K => 2,
  Q => 2,
    );

my %tilevalue=(
  A => 1,
  G => 1,
  I => 1,
  S => 1,
  U => 1,
  X => 1,
  Z => 1,
  E => 2,
  J => 2,
  L => 2,
  R => 2,
  V => 2,
  Y => 2,
  F => 3,
  D => 3,
  P => 3,
  W => 3,
  B => 4,
  N => 4,
  T => 5,
  O => 5,
  H => 5,
  M => 5,
  C => 5,
  K => 10,
  Q => 10,
    );

my @bag=shuffle map {($_) x $tilecount{$_}} keys %tilecount;
splice @bag,$l;

my %w;
open I,'<','wordlist';
while (<I>) {
  chomp;
  if (length($_)<=$l) {
    $w{uc($_)}=1;
  }
}
close I;

my $maxscore=0;
my @maxcandidate;
my %tried;

my @permute=(0..$#bag);
my @dir=(-1) x @permute;
$dir[0]=0;

while (1) {
  my @candidate=map {$bag[$_]} @permute;
  while (@candidate) {
    my $candidate=join('',@candidate);
    if (exists $tried{$candidate}) {
      last;
    }
    $tried{$candidate}=1;
    if (exists $w{$candidate}) {
      my $score=sum(map {$tilevalue{$_}} @candidate);
      if ($score > $maxscore) {
        @maxcandidate=();
        $maxscore=$score;
      }
      if ($score == $maxscore) {
        push @maxcandidate,$candidate;
      }
      last;
    }
    pop @candidate;
  }
  my %find=map {$permute[$_] => $_} (0..$#permute);
  my $m=$#permute;
  while ($m>=0) {
    my $pos=$find{$m};
    unless ($dir[$pos]==0) {
      if ($m > $permute[$pos+$dir[$pos]]) {
        my $n=$pos+$dir[$pos];
        my $nn=$n+$dir[$pos];
        ($permute[$n],$permute[$pos])=($permute[$pos],$permute[$n]);
        ($dir[$n],$dir[$pos])=($dir[$pos],$dir[$n]);
        if ($n==0 || $n==$#permute || $permute[$nn] > $m) {
          $dir[$n]=0;
        }
        foreach my $i (0..$#permute) {
          if ($i==$n) {
            next;
          }
          if ($permute[$i]>$m) {
            $dir[$i]=($i<$n)?1:-1;
          }
        }
        last;
      }
    }
    $m--;
  }
  if ($m<0) {
    last;
  }
}

print join('',sort @bag),"\n";
print "$maxscore: ",join(' ',sort @maxcandidate),"\n";
