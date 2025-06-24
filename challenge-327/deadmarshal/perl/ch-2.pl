#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub mad{
  my @s = sort{$a <=> $b} @{$_[0]};
  my @mad = $s[1] - $s[0];
  foreach my $i(1..$#s){
    my $diff = abs $s[$i] - $s[$i-1];
    $mad[0] = $diff if $diff < $mad[0];
    push @mad,[@s[$i-1,$i]] if $diff == $mad[0]
  }
  @mad[1..$#mad]
}

print show mad([4,1,2,3]);
print show mad([1,3,7,11,15]);
print show mad([1,5,3,8]);

