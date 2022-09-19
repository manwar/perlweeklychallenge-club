#!/usr/bin/env perl
use strict;
use warnings;

sub is_prime{
  my ($n) = @_;
  if($n <= 1){return 0;}
  foreach(2..sqrt($n)){
    return 0 if $n % $_ == 0;
  }
  return 1;
}

foreach(1..1000){
  print "$_ " if ($_ == reverse $_) && (is_prime($_));
}

