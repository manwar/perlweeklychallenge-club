#!/usr/bin/perl
use warnings;
use strict;

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-045/ Task #1

my $code  = shift || "The quick brown fox jumps over the lazy dog";  
my $block = shift || 8; 

$code =~ s/ //g;
my @code = split(//,$code);

my @out;
my $m = 0;
$out[$m++ % $block] .= shift(@code) while (@code);
print "$_ " foreach (@out);
print "\n";

__END__

./ch-1.pl
Tbjrd hruto eomhg qwpe unsl ifoa covz kxey

./ch-1.pl "The quick brown fox jumps over the lazy dog" 17
Tug hm ep qs uo iv ce kr bt rh oe wl na fz oy xd jo

./ch-1.pl "Now is the time for all good men to come to the aid of their party"
Ntlnofr oiltttt wmgohhy ieocee sfooai todmir hrmedp eaetoa

./ch-1.pl "Now is the time for all good men to come to the aid of their party" 10
Nmoefy oedtt wfmoh ioete srnhi tater hloap elcia tgodr iomot

