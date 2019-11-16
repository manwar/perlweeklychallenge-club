#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(sum);

my @data=map {rand()} (1..10);

my @ma=map {sum(@data[$_-1..$_+1])/3} (1..$#data-1);

unshift @ma,'';
push @ma,'';

my @out=map {[$data[$_],$ma[$_]]} (0..$#data);

print tabular(\@out);

sub tabular {
  my $d=shift;
  my @columnlength;
  foreach my $row (@{$d}) {
    foreach my $colno (0..$#{$row}) {
      if (!defined($columnlength[$colno]) ||
          $columnlength[$colno] < length($row->[$colno] || '')) {
        $columnlength[$colno]=length($row->[$colno]);
      }
    }
  }
  my $format=join('  ',map {"%${_}s"} @columnlength);
  my $result='';
  foreach my $row (@{$d}) {
    $result .= sprintf($format,@{$row})."\n";
  }
  return $result;
}
