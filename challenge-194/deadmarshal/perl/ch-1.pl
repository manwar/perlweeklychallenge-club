#!/usr/bin/env perl
use strict;
use warnings;

sub digital_clock{
  my ($str) = @_;
  if($str =~ /(.)(.):(.)(.)/){
    $1 eq '?' ? ($2 < 4 ? 2 : 1)
      : $2 eq '?' ? ($1 < 2 ? 9 : 3)
      : $3 eq '?' ? 5 : 9;
  }
}

print digital_clock('?5:00'), "\n";
print digital_clock('?3:00'), "\n";
print digital_clock('1?:00'), "\n";
print digital_clock('2?:00'), "\n";
print digital_clock('12:?5'), "\n";
print digital_clock('12:5?'), "\n";

