#! /usr/bin/perl6

use Test;

plan 2;

is-deeply(fp('""[]()','"I like (parens) and the Apple ][+" they said.'),['"(["','")]"'],'example 1');
is-deeply(fp('**//<>','/* This is a comment (in some languages) */ <could be a tag>'),['/**/<','/**/>'],'example 2');

sub fp($delims,$sample) {
  my @d=(SetHash.new,SetHash.new);
  for 0..chars($delims)-1 -> $i {
    @d[$i % 2]{substr($delims,$i,1)}++;
  }
  my @o=(Array.new,Array.new);
  for $sample.comb -> $s {
    for 0,1 -> $x {
      if (@d[$x]{$s}:exists) {
        push @(@o[$x]),$s;
      }
    }
  }
  return [map {join('',@($_))}, @o];
}
