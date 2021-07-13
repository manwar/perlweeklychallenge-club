#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is_deeply(tsp([
  [0, 2, 9, 10],
  [1, 0, 6, 4],
  [15, 7, 0, 8],
  [6, 3, 12, 0],
    ]),[21,[0,2,3,1,0]],'example 1');

is_deeply(tsp([
  [0, 5, 2, 7],
  [5, 0, 5, 3],
  [3, 1, 0, 6],
  [4, 5, 4, 0],
    ]),[10,[0,2,1,3,0]],'example 2');

use YAML::XS;
print Dump(tsp(mkmatrix(10)));

use Algorithm::Permute;
use List::Util qw(min);

sub tsp {
  my ($d)=shift;
  my $n=scalar @{$d};
  my $n1=$n-1;
  my %c;
  foreach my $k (1..$n1) {
    $c{1<<$k}{$k}=[$d->[0][$k],0];
  }
  foreach my $ss (2..$n1) {
    my $p=Algorithm::Permute->new([1..$n1],$ss);
    while (my @s = $p->next) {
      my $bits=0;
      foreach my $bit (@s) {
        $bits |= 1 << $bit;
      }
      foreach my $k (@s) {
        my $prev=$bits & ~(1<<$k);
        my @res;
        foreach my $m (@s) {
          if ($m==0 || $m==$k) {
            next;
          }
          push @res,[$c{$prev}{$m}[0]+$d->[$m][$k],$m];
        }
        my @r=map {$_->[0]} @res;
        my %r=map {$r[$_] => $_} (0..$#r);
        $c{$bits}{$k}=$res[$r{min(@r)}];
      }
    }
  }
  my $bits=(1<<$n)-1 & ~1;
  my @res;
  foreach my $k (1..$n1) {
    push @res,[$c{$bits}{$k}[0]+$d->[$k][0],$k];
  }
        my @r=map {$_->[0]} @res;
  my %r=map {$r[$_] => $_} (0..$#r);
  my ($opt,$parent)=@{$res[$r{min(@r)}]};
  my @path;
  foreach my $i (0..$n1-1) {
    push @path,$parent;
    my $nb=$bits & ~(1 << $parent);
    $parent=$c{$bits}{$parent}[1];
    $bits=$nb;
  }
  push @path,0;
  @path=reverse @path;
  push @path,0;
  return [$opt,\@path];
}

sub mkmatrix {
  my $n=shift;
  my $n1=$n-1;
  my @r;
  foreach my $x (0..$n1) {
    my @a;
    foreach my $y (0..$n1) {
      if ($x==$y) {
        push @a,0;
      } else {
        push @a,int(rand()*10)+1;
      }
    }
    push @r,\@a;
  }
  return \@r;
}
