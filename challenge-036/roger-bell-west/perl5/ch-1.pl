#! /usr/bin/perl

use strict;
use warnings;

# Write a program to validate given Vehicle Identification Number (VIN).

my %cvalue;
map {$cvalue{$_}=$_} (0..9);
my $base=ord('A');
foreach my $char ('A'..'H','J'..'N','P','R') {
  $cvalue{$char}=(ord($char)-$base)%9+1;
}
foreach my $char ('S'..'Z') {
  $cvalue{$char}=(ord($char)-$base)%9+2;
}
my $valid=join('',keys %cvalue);

my @weight=reverse (2..9,0,10,2..8);

foreach my $vin (@ARGV) {
  unless (length($vin)==17) {
    print "$vin is not 17 characters\n";
    next;
  }
  unless ($vin =~ /^[$valid]*$/) {
    print "$vin contains invalid characters\n";
    next;
  }
  my $check=0;
  foreach my $ix (0..16) {
    $check+=$cvalue{substr($vin,$ix,1)}*$weight[$ix];
  }
  $check%=11;
  if ($check==10) {
    $check='X';
  }
  if (substr($vin,8,1) ne $check) {
    print "$vin does not pass check-digit verification (may be valid non-NA)\n";
    next;
  }
  print "$vin is valid.\n";
}
