#!/usr/bin/perl

use warnings;

sub inittrs($) {
  my ($shift) = @_;
  my $p1=" ";
  my $p2=" ";
  for my $t (0..25) {
     $p1 .= chr(ord('A')+$t);  
     $p2 .= chr(ord('A')+($t-$shift)%26);
  }
  return ($p1,$p2);
}

$S = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG";
$N = 3;

($plain,$cipher)= inittrs($N);
print "Plain:    $plain\n";
print "Cipher:   $cipher\n";

eval ("\$S=~ tr/$plain/$cipher/");
print "$S\n";
