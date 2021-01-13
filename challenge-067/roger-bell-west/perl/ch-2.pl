#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is_deeply(expand('35'),
          ["dj", "dk", "dl", "ej", "ek", "el", "fj", "fk", "fl"],
          'expansion 35',
            );

sub expand {
  my ($digits)=@_;
  my %table=(
    2 => [qw(a b c)],
    3 => [qw(d e f)],
    4 => [qw(g h i)],
    5 => [qw(j k l)],
    6 => [qw(m n o)],
    7 => [qw(p q r s)],
    8 => [qw(t u v)],
    9 => [qw(w x y z)],
      );
  my @d=grep {exists $table{$_}} split '',$digits;
  my @out;
  my @a;
  do {
    my $s=[];
    if (@a) {
      $s=shift @a;
    }
    my $l=scalar @{$s};
    if ($l <= $#d) {
      foreach my $dx (@{$table{$d[$l]}}) {
        push @a,[@{$s},$dx];
      }
    } else {
      push @out,join('',@{$s});
    }
  } while @a;
  return \@out;
}
