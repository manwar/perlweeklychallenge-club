#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(fractionaladditionsubstraction('1/2+3/2'), '2/1', 'example 1');
is(fractionaladditionsubstraction('-5/2-3/2'), '-4/1', 'example 2');
is(fractionaladditionsubstraction('5/3-5/3'), '0/1', 'example 3');
is(fractionaladditionsubstraction('10/10-1/10+2/5'), '13/10', 'example 4');
is(fractionaladditionsubstraction('1/6+1/6+1/6'), '1/2', 'example 5');

sub fractionaladditionsubstraction($a) {
  my @terms;
  my $state = 0;
  my $n = 0;
  my $num = 0;
  my $sign = 0;
  my @cv = split '', $a;
  my $i = 0;
  while ($i < scalar @cv) {
    if ($state == 0) {
      if ($cv[$i] eq '+') {
        $state = 0;
        $i++;
      } elsif ($cv[$i] ge '0' && $cv[$i] le '9') {
        $sign = 1;
        $state = 1;
        $n = 0 + $cv[$i];
        $i++;
      } elsif ($cv[$i] eq '-') {
        $sign = -1;
        $state = 1;
        $n = 0;
        $i++;
      }
    } elsif ($state == 1) {
      if ($cv[$i] ge '0' && $cv[$i] le '9') {
        $n = $n * 10 + $cv[$i];
        $i++;
      } elsif ($cv[$i] eq '/') {
        $num = $n * $sign;
        $n = 0;
        $state = 2;
        $i++;
      }
    } elsif ($state == 2) {
      if ($cv[$i] ge '0' && $cv[$i] le '9') {
        $n = $n * 10 + $cv[$i];
        $i++;
      } else {
        push @terms, Local::Rational->new($num, $n);
        $state = 0;
      }
    }
  }
  if ($state == 2) {
    push @terms, Local::Rational->new($num, $n);
  }
  use Data::Dumper;
  my $out = $terms[0];
  foreach my $nti (1 .. $#terms) {
    $out->add($terms[$nti]);
  }
  return $out->stringify();
}

package Local::Rational;

sub gcd {
  my ($m,$n)=@_;
  while ($n!=0) {
    ($m,$n)=($n,$m % $n);
  }
  return $m;
}

sub lcm {
  my ($m,$n)=@_;
  return $m/gcd($m,$n)*$n;
}

sub new {
  my $class = shift;
  my $self={
    n => 1,
    d => 1,
      };
  bless $self,$class;
  if (scalar @_ == 2) {
    $self->{n} = $_[0];
    $self->{d} = $_[1];
  }
  $self->reduce;
  return $self;
}

sub reduce {
  my $self = shift;
  my $gcd = gcd($self->{n}, $self->{d});
  if ($gcd > 1) {
    $self->{n} /= $gcd;
    $self->{d} /= $gcd;
  }
}

sub add {
  my $self = shift;
  my $other = shift;
  my $lcm = lcm($self->{d}, $other->{d});
  my $n = $self->{n} * $lcm / $self->{d} + $other->{n} * $lcm / $other->{d};
  $self->{n} = $n;
  $self->{d} = $lcm;
  $self->reduce;
}

sub stringify {
  my $self=shift;
  return join('/', $self->{n}, $self->{d});
}
