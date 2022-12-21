#!/usr/bin/env perl
use strict;
use warnings;

sub frequency_equalizer{
  my ($str) = @_;
  my %hash;
  $hash{$_}++ foreach split '', $str;
  my @sorted = sort {$b <=> $a} values %hash;
  $sorted[0] == $sorted[1]+1 && $sorted[-1] == $sorted[1] ? 1 : 0;
}

print frequency_equalizer('abbc'), "\n";
print frequency_equalizer('xyzyyxz'), "\n";
print frequency_equalizer('xzxz'), "\n";

