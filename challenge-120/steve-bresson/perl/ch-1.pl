#!/usr/bin/perl -w
require 5.0;
#-----------------------------------------------------------------------

=head1 NAME

 ch-1.pl - Perl Weekly Challenge #120

=head1 SYNOPSIS

ch-1.pl {0-255}

=head1 DESCRIPTION

https://theweeklychallenge.org/blog/perl-weekly-challenge-120/

=head1 MODIFICATIONS/AUTHOR

  2021/7/5,Steve Bresson    Created ch-1.pl

=cut

#-----------------------------------------------------------------------
use strict;

print "Task 1: Swap Odd/Even bits on an 8 bit value\n";

my $in = (shift || 101) + 0;
printf "IN:  %3d = 0x%02x\n", $in, $in;

my $out = (($in & 0x55)<<1) | (($in & 0xaa)>>1);
printf "OUT: %3d = 0x%02x\n", $out, $out;

print "Finito!\n";
exit(0);
#-----------------------------------------------------------------------
