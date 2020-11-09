#! /usr/bin/perl

use strict;
use warnings;

my @symbols=('1'..'9');
my $order=3;

my $sqo=$order*$order;
my $sqo1=$sqo-1;
my @p;
my $ss=join('',@symbols);
my @r;

open I,'<',($ARGV[0] || 'puzzle');
while (<I>) {
  chomp;
  s/[ \[\]]+//g;
  push @p,[map {if (/[$ss]/) {$_} else {''} } split '',$_];
  my @ra;
  foreach (0..$#{$p[-1]}) {
    if ($p[-1][$_] eq '') {
      push @ra,{map {$_ => 1} @symbols};
    } else {
      push @ra,{$p[-1][$_] => 1};
    }
  }
  push @r,\@ra;
}

my @cset;
foreach my $ri (0..$sqo1) {
  push @cset,[map {[$ri,$_]} (0..$sqo1)];
}
foreach my $ci (0..$sqo1) {
  push @cset,[map {[$_,$ci]} (0..$sqo1)];
}
for (my $rb=0;$rb<$sqo1;$rb+=$order) {
  for (my $cb=0;$cb<$sqo1;$cb+=$order) {
    my @c;
    foreach my $ri ($rb..$rb+$order-1) {
      foreach my $ci ($cb..$cb+$order-1) {
        push @c,[$ri,$ci];
      }
    }
    push @cset,\@c;
  }
}

while (!solved(\@p)) {
  my $dirty=0;
  foreach my $c (@cset) {
    $dirty+=eliminate_1(\@p,\@r,$c);
  }
  unless ($dirty) {
    foreach my $c (@cset) {
      $dirty+=eliminate_open_tuple(\@p,\@r,$c);
    }
  }
  unless ($dirty) {
    warn "I give up\n";
    last;
  }
}

foreach my $r (@p) {
  print join(' ',map {$_ eq ''?'_':$_} @{$r}),"\n";
}

sub solved {
  my @p=@{$_[0]};
  foreach my $r (@p) {
    foreach my $c (@{$r}) {
      if ($c eq '') {
        return 0;
      }
    }
  }
  return 1;
}

sub eliminate_1 {
  my $p=shift;
  my $r=shift;
  my $c=shift;
  my %rm;
  my $dirty=0;
  foreach my $cp (@{$c}) {
    if ($p->[$cp->[0]][$cp->[1]] ne '') {
      $rm{$p->[$cp->[0]][$cp->[1]]}=1;
    }
  }
  if (%rm) {
    foreach my $cp (@{$c}) {
      if ($p->[$cp->[0]][$cp->[1]] eq '') {
        map {delete $r->[$cp->[0]][$cp->[1]]{$_}} keys %rm;
        if (scalar keys %{$r->[$cp->[0]][$cp->[1]]}==1) {
          $p->[$cp->[0]][$cp->[1]]=(keys %{$r->[$cp->[0]][$cp->[1]]})[0];
          $dirty=1;
        }
      }
    }
  }
  return $dirty;
}

sub eliminate_open_tuple {
  my $p=shift;
  my $r=shift;
  my $c=shift;
  my $dirty=0;
  my %pa;
  foreach my $i (0..$#{$c}) {
    my $cp=$c->[$i];
    my $s=join('',sort keys %{$r->[$cp->[0]][$cp->[1]]});
    if (length($s)>1) {
      $pa{$s}{$i}=1;
    }
  }
  foreach my $tuple (keys %pa) {
    if (scalar keys %{$pa{$tuple}}==length($tuple)) {
      my @t=split '',$tuple;
      foreach my $i (0..$#{$c}) {
        my $cp=$c->[$i];
        unless (exists $pa{$tuple}{$i}) {
          foreach my $x (@t) {
            if (delete $r->[$cp->[0]][$cp->[1]]{$x}) {
              $dirty=1;
            }
          }
          if (scalar keys %{$r->[$cp->[0]][$cp->[1]]}==1) {
            $p->[$cp->[0]][$cp->[1]]=(keys %{$r->[$cp->[0]][$cp->[1]]})[0];
          }
        }
      }
    }
  }
  return $dirty;
}
