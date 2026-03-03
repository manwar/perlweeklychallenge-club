#!/usr/bin/env perl

use Modern::Perl;

@ARGV==2 or die "usage: $0 address mask\n";
my($node_addr, $network_addr) = @ARGV;

my $node_ip = parse_ip($node_addr);
my($network_ip, $network_mask) = parse_network_ip($network_addr);
my $in_network = ($node_ip & $network_mask) == ($network_ip & $network_mask);
say $in_network ? "true" : "false";


sub parse_ip {
    my($addr) = @_;
    my @bytes = split(/\./, $addr);
    @bytes == 4 or die "invalid address $addr\n";
    my $ip = ($bytes[0] << 24) | ($bytes[1] << 16) | ($bytes[2] << 8) | $bytes[3];
    return $ip;
}

sub get_mask {
    my($mask_bits) = @_;
    my $text = "0b" . ('1' x $mask_bits) . ('0' x (32 - $mask_bits));
    my $mask = eval($text);
    $@ and die $@;
    return $mask;
}

sub parse_network_ip {
    my($addr) = @_;
    my($network_addr, $mask_bits) = split(/\//, $addr, 2);

    my $network_ip = parse_ip($network_addr);
    my $network_mask = get_mask($mask_bits);

    return ($network_ip, $network_mask);
}
