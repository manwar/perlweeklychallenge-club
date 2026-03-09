#!/usr/bin/perl
use 5.038;
use warnings;
use builtin qw/ true false /;
no warnings qw/ experimental::builtin /;

sub validIPv4($ip) {
    unless ($ip =~ /^(\d+)\.(\d+)\.(\d+)\.(\d+)$/) {
        return false;
    }
    
    my @octets = split /\./, $ip;
    
    for my $octet (@octets) {
        unless ($octet >= 0 && $octet <= 255) {
            return false;
        }
    }
    
    return true;
}

sub validCIDR($cidr) {
    unless ($cidr =~ /^(.+)\/(\d+)$/) {
        return false;
    }
    
    my ($network, $prefix) = split /\//, $cidr;
    
    unless (validIPv4($network)) {
        return false;
    }
    
    unless ($prefix >= 0 && $prefix <= 32) {
        return false;
    }
    
    return true;
}

sub IPToInt($ip) {
    my @octets = split /\./, $ip;
    return ($octets[0] << 24) + ($octets[1] << 16) + ($octets[2] << 8) + $octets[3];
}

sub addressInNetwork($address, $networkcidr) {
    unless (validIPv4($address)) {
        return false;
    }
    
    unless (validCIDR($networkcidr)) {
        return false;
    }
    
    my ($network, $prefix) = split /\//, $networkcidr;
    my $addressInt = IPToInt($address);
    my $netInt = IPToInt($network);
    my $mask = (0xFFFFFFFF << (32 - $prefix)) & 0xFFFFFFFF;
    
    return ($addressInt & $mask) == ($netInt & $mask);
}

my ($address, $network) = @ARGV;

say addressInNetwork($address, $network) ? 'true' : 'false';