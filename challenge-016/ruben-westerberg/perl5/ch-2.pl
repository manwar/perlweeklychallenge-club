#!/usr/bin/env perl
use strict;
use warnings;
use bigint;;
use Digest::SHA qw(sha256 sha256_hex);
use v5.26;

my @addresses=@ARGV;
@addresses= qw<1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2
	3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy> unless @addresses;

my %b;
for ("1".."9","A".."H","J".."N","P".."Z","a".."k","m".."z") {
	state $i=0;
	$b{$_}=$i++;
}

for (@addresses) {
	print "Testing Address: $_\n";
	if (/[IlO]/) { print  "Invalid characters found: $_\n"; next};
	my $sum=0;
	my @a=reverse (split ("", $_));
	while (my ($k,$v)=each @a) {
		my $in=$b{$v};
		$sum+=$in *(58**$k);;
	}
	my $bytes=$sum->as_bytes();
	unless (length $bytes <= 25) { print  "Invalid length: $_\n";next }
	my $buff='';
	vec($buff,$_,8)=0x00 for (0..24);
	my $offset=length($buff)-length($bytes);
	substr($buff,$offset,length($bytes),$bytes);
	my $check= substr(sha256(sha256(substr $buff,0,21)),0,4);
	my $inCheck=substr($buff,21,4);
	unless ($check eq $inCheck) { print "Check sum mismatch: $_\n";next};
	print "Address OK: $_\n\n";

}
