#!/usr/bin/perl -w
require 5.0;
#-----------------------------------------------------------------------

=head1 NAME

 week120.pl - Perl Weekly Challenge #120

=head1 SYNOPSIS

week120.pl [-{h|d|v}]  {0-255} {"HR:MN"}

=head1 DESCRIPTION

https://theweeklychallenge.org/blog/perl-weekly-challenge-120/

=head1 MODIFICATIONS/AUTHOR

  2021/7/5,Steve Bresson	Created week120.pl

=cut

#-----------------------------------------------------------------------
use strict;

print "Task 1: Swap Odd/Even bits on an 8 bit value\n";

my $in = (shift || 101) + 0;
printf "IN:  %3d = 0x%02x\n", $in, $in; 

my $out = (($in & 0x55)<<1) | (($in & 0xaa)>>1);
printf "OUT: %3d = 0x%02x\n", $out, $out; 


#-----------------------------------------------------------------------
# Note: 12 hrs => 360/12 = 30 deg/hr
# 60 min => 360/60 = 6 deg/min
# Fine Motion of Hr hand:  30deg/60min = 0.5 deg/min

print "Task 2: Clock Angle\n";
my $t = shift || "03:18";
my($h,$m) = $t =~ m|(\d+):(\d+)|;

my $h30 = 30 * $h;
my $m6 = 6 * $m;
my $h3x = $h30 + (0.5 * $m);

print "IN: $t = $h : $m\n";

#($h30,$m6) = ($m6,$h30) if $h30 < $m6;
my $dc = abs($h30 - $m6); # COARSE approx
print "C-OUT: $dc degree\n";

#($h3x,$m6) = ($m6,$h3x) if $h3x < $m6;
my $df = abs($h3x - $m6); # FINE approx
print "F-OUT: $df degree\n";



print "Finito!\n";
exit(0);
#-----------------------------------------------------------------------
