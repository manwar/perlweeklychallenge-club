#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(encrypt("playfair example",
           "hide the gold in the tree stump"),
   "bmodzbxdnabekudmuixmmouvif",'example 1');

is(decrypt("perl and raku",
           "siderwrdulfipaarkcrw"),
   "thewexeklychallengex",'example 2');

sub encrypt {
  my ($kw,$plaintext)=@_;
  return playfair(1,$kw,$plaintext);
}

sub decrypt {
  my ($kw,$ciphertext)=@_;
  return playfair(-1,$kw,$ciphertext);
}

sub playfair {
  my ($dir,$kwi,$input)=@_;
  my $kw='';
  {
    my %k;
    foreach my $char (split '',lc($kwi).join('','a'..'z')) {
      if ($char eq 'j') {
        $char='i';
      }
      if ($char =~ /[a-z]/) {
        unless (exists $k{$char}) {
          $k{$char}=1;
          $kw.=$char;
        }
      }
    }
  }
  my @grid;
  my %gc;
  {
    my $index=0;
    foreach my $row (0..4) {
      my @r;
      foreach my $column (0..4) {
        push @r,substr($kw,$index,1);
        $gc{substr($kw,$index,1)}=[$row,$column];
        $index++;
      }
      push @grid, \@r;
    }
  }
  my $ii=lc($input);
  $ii =~ s/[^a-z]//g;
  $ii =~ s/j/i/g;
  my @ichars=split '',$ii;
  my $out = '';
  my $index=0;
  while ($index < scalar @ichars) {
    my $ca=$ichars[$index];
    my $cb=$ichars[$index+1] || 'x';
    $index+=2;
    if ($ca eq $cb) {
      $cb='x';
      $index--;
    }
    my ($car,$cac)=@{$gc{$ca}};
    my ($cbr,$cbc)=@{$gc{$cb}};
    my ($oar,$oac,$obr,$obc)=($car,$cac,$cbr,$cbc);
    if ($car == $cbr) {
      $oac=posmod($cac+$dir,5);
      $obc=posmod($cbc+$dir,5);
    } elsif ($cac == $cbc) {
      $oar=posmod($car+$dir,5);
      $obr=posmod($cbr+$dir,5);
    } else {
      $oac=$cbc;
      $obc=$cac;
    }
    $out .= $grid[$oar][$oac] . $grid[$obr][$obc];
  }
  return $out;
}

sub posmod {
  my ($a,$b)=@_;
  my $m=$a % $b;
  while ($m < 0) {
    $m += $b;
  }
  return $m;
}
