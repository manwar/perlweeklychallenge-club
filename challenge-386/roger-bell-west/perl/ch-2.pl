#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(rationalnumbers('0.(12)', '0.(121)'), 0, 'example 1');
is(rationalnumbers('0.1(23)', '0.12(32)'), 1, 'example 2');
is(rationalnumbers('0.1(234)', '0.12(342)'), 1, 'example 3');
is(rationalnumbers('12.99(99)', '13.'), 1, 'example 4');
is(rationalnumbers('0.(123)', '0.1(231)'), 1, 'example 5');

sub rationalnumbers($a, $b) {
  str2rat($a)->equals(str2rat($b)) ? 1:0;
}

sub str2rat($a) {
  my $fixedpart;
  my $repeatpart;
  if ($a =~ /^(.*)\((.*)\)$/) {
    $fixedpart = $1;
    $repeatpart = $2;
  } else {
    $fixedpart = $a;
    $repeatpart = '0';
  }
  my $point = index($fixedpart, '.');
  my $tens = length($fixedpart) - $point - 1;
  my $n = substr($fixedpart, 0, $point) . substr($fixedpart, $point + 1);
  my $v = Local::Fraction->new($n, 10 ** $tens);
  my $repeatd = 10 ** length($repeatpart) - 1;
  my $w = Local::Fraction->new($repeatpart, (10 ** $tens) * $repeatd);
  $v->add($w);
  $v;
}

package Local::Fraction;

sub lcm {
  my ($m, $n)=@_;
  return $m / gcd($m, $n) * $n;
}

sub gcd($m, $n) {
  while ($n!=0) {
    ($m, $n)=($n, $m % $n);
  }
  return $m;
}

sub new {
  my $class=shift;
  my $self={
    n => 1,
    d => 1,
      };
  bless $self,$class;
  if (scalar @_ == 1) {
    $self->set_from_string($_[0]);
  } elsif (scalar @_ == 2) {
    $self->{n} = $_[0];
    $self->{d} = $_[1];
  }
  $self->reduce;
  return $self;
}

sub reduce {
  my $self = shift;
  my $gcd = gcd($self->{n}, $self->{d});
  $self->{n} /= $gcd;
  $self->{d} /= $gcd;
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

sub equals {
  my $self = shift;
  my $other = shift;
  return $self->{n} == $other->{n} && $self->{d} == $other->{d};
}

sub stringify {
  my $self=shift;
  return join('/', $self->{n}, $self->{d});
}

sub set_from_string {
  my $self = shift;
  my $s = shift;
  if ($s =~ /^([0-9]+)\/([0-9]+)$/) {
    $self->{n}=$1;
    $self->{d}=$2;
  }
}
