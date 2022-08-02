#!/usr/bin/env perl
use strict;
use warnings;
use ntheory qw(euler_phi);

sub phi_iter{
  my ($n) = @_;
  euler_phi($n) + ($n == 2 ? 0 : phi_iter(euler_phi($n)))
}

my $i = 2;
my $count = 0;
while($count != 20){
  if($i == phi_iter($i)){
    print "$i ";
    $count++;
  }
  $i++
}
