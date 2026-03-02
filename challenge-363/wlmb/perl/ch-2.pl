#!/usr/bin/env perl
# Perl weekly challenge 363
# Task 2:  Subnet Sheriff
#
# See https://wlmb.github.io/2026/03/02/PWC363/#task-2-subnet-sheriff
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 I0 D0 I1 D1...
    to find if the internet address In corresponds to domain Dn.
    In should be of the form a.b.c.d, with a...d  digital numbers, while
    Dn should consist be of the form a.d.c.d/e, with a...e digital numbers.
    FIN
for my($address, $domain)(@ARGV){
    try {
	my @address_parts = split /\./, $address;
	(my $network = $domain)=~s[/(\d+)$][];  # remove mask bit count
	die "Missing mask size: $domain" unless defined $1;
	my $mask_size=$1;
	my $mask=0;
	$mask = 2*$mask + $_ for((1)x$1,(0)x(32-$1)); # binary mask
	my @domain_parts = split /\./, $network;
	my ($bin_address,$bin_domain) =
	    map {my $t=0; $t=$t*256+$_ for @$_;$t}[@address_parts],[@domain_parts];
	my $result = ($bin_address^$bin_domain)&$mask;
	say "$address, $domain -> ", $result?"False":"True";
    }
    catch($e){ warn $e }
}
