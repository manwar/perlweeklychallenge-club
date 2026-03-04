#!/usr/bin/env perl
#
=head1 Task 2: Subnet Sheriff

Submitted by: Peter Campbell Smith

You are given an IPv4 address and an IPv4 network (in CIDR format).  Write a
script to determine whether both are valid and the address falls within the
network. For more information see the Wikipedia article.

=head2 Example 1

    Input: $ip_addr = "192.168.1.45"
           $domain  = "192.168.1.0/24"
    Output: true

=head2 Example 2

    Input: $ip_addr = "10.0.0.256"
           $domain  = "10.0.0.0/24"
    Output: false

=head2 Example 3

    Input: $ip_addr = "172.16.8.9"
           $domain  = "172.16.8.9/32"
    Output: true

=head2 Example 4

    Input: $ip_addr = "172.16.4.5"
           $domain  = "172.16.0.0/14"
    Output: true

=head2 Example 5

    Input: $ip_addr = "192.0.2.0"
           $domain  = "192.0.2.0/25"
    Output: true

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [["192.168.1.45", "192.168.1.0/24"],  true, "Example 1"],
    [[  "10.0.0.256",    "10.0.0.0/24"], false, "Example 2"],
    [[  "172.16.8.9",  "172.16.8.9/32"],  true, "Example 3"],
    [[  "172.16.4.5",  "172.16.0.0/14"],  true, "Example 4"],
    [[   "192.0.2.0",   "192.0.2.0/25"],  true, "Example 5"],
    [[     "192.0.2",   "192.0.2.0/25"], false, "Example 6"],
    [[   "192.0.2.0",   "192.0.2.0+25"], false, "Example 7"],
    [[  "10.0.0.255",  "10.256.0.0/24"], false, "Example 8"],
];

sub subnet_sheriff
{
    my $ip_addr  = $_[0]->[0];
    my $net_mask = $_[0]->[1];

    return false unless $ip_addr  =~ /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/
                     && $net_mask =~ /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(?:\/([1-2]?[0-9]|3[0-2]))$/;

    my ($net_base, $mask) = split("/", $net_mask);

    my $ip   = unpack("N", pack("C4", split(/\./, $ip_addr)));
    my $base = unpack("N", pack("C4", split(/\./, $net_base)));

    my $net_mask_int = (2**$mask - 1) << (32 - $mask);

    return ($ip & $net_mask_int) == ($base & $net_mask_int);
}

for (@$cases) {
    is(subnet_sheriff($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
