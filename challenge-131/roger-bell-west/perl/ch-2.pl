#! /usr/bin/perl

use strict;

use Test::More tests => 2;

is_deeply(fp('""[]()','"I like (parens) and the Apple ][+" they said.'),['"(["','")]"'],'example 1');
is_deeply(fp('**//<>','/* This is a comment (in some languages) */ <could be a tag>'),['/**/<','/**/>'],'example 2');

sub fp {
  my ($delims,$sample)=@_;
  my @d;
  foreach my $i (0..length($delims)-1) {
    $d[$i % 2]->{substr($delims,$i,1)}=1;
  }
  my @o;
  foreach my $s (split '',$sample) {
    foreach my $x (0,1) {
      if (exists $d[$x]->{$s}) {
        push @{$o[$x]},$s;
      }
    }
  }
  return [map {join('',@{$_})} @o];
}
