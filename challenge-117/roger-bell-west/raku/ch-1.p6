#! /usr/bin/perl6

use Test;

plan 1;

is(mr('infile'),12,'example 1');

sub mr($n) {
  my $f=SetHash.new;
  my $fh=open :r,$n or die "Cant open file\n";
  for $fh.lines {
    .chomp;
    if (/^(<[0..9]>+)/) {
      $f{$0+0}=1;
    }
  }
  my $a=1;
  while (1) {
    unless ($f{$a}:exists) {
      return $a;
    }
    $a++;
  }
}
