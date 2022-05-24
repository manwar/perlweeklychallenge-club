#! /usr/bin/perl

use strict;
use warnings;

use experimental 'signatures';

use List::Util qw(sum0);

use Test::More tests => 6;

is(scalar @{hexwords(2,8,8)},1463,'example 1');

is(scalar @{hexwords(8,8,8)},164,'example 2');

is(scalar @{hexwords(2,8,0)},45,'example 3');

is(scalar @{hexwords(2,8,1)},244,'example 4');

is(scalar @{combiwords(hexwords(4,4,0),8)},144,'example 5');

is(scalar @{combiwords(hexwords(3,5,0),8)},274,'example 6');

sub hexwords($lo,$hi,$sb) {
  my @out;
  open my $fh,'<','dictionary.txt';
  while (my $line = <$fh>) {
    chomp $line;
    if (length($line) >= $lo && length($line) <= $hi) {
      my $valid = 1;
      my $sbc = 0;
      foreach my $c (split '',$line) {
        if ($c =~ /[oilst]/) {
          $sbc++;
          if ($sbc > $sb) {
            $valid = 0;
          }
        } elsif ($c lt 'a' || $c gt 'f') {
          $valid = 0;
        }
        unless ($valid) {
          last;
        }
      }
        if ($valid) {
          push @out,$line;
        }
    }
  }
  close $fh;
  return \@out;
}

sub combiwords($wl,$l) {
  my %wh;
  foreach my $w (@{$wl}) {
    push @{$wh{length($w)}},$w;
  }
  my @tmap=([]);
  my @omap;
  while (scalar @tmap > 0) {
    my $c=pop @tmap;
    my $s=sum0(@{$c});
    my $ls=$l-$s;
    foreach my $j (1..$ls-1) {
      if (exists $wh{$j}) {
        push @tmap,[@{$c},$j];
      }
    }
    if (exists $wh{$ls}) {
      push @omap,[@{$c},$ls];
    }
  }
  my @out;
  foreach my $pat (@omap) {
    my @c = (0) x (scalar @{$pat});
    my @cm = map {scalar @{$wh{$pat->[$_]}}-1} (0..$#c);
    my $ex = 0;
    while (!$ex) {
      push @out,join('',map {$wh{$pat->[$_]}->[$c[$_]]} (0..$#c));
      my $ss = $#c;
      while (1) {
        $c[$ss]++;
        if ($c[$ss] > $cm[$ss]) {
          if ($ss == 0) {
            $ex = 1;
            last;
          }
          $c[$ss] = 0;
          $ss--;
        } else {
          last;
        }
      }
    }
  }
  return \@out;
}
