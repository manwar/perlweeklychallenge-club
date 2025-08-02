#!/usr/bin/perl
use strict;
use warnings;

=begin
  Here my solution TASK #1 along with alternatives from Niels van Dijke and James Curtis-Smith.
  I did some benchmark (https://metacpan.org/pod/Benchmark) with 'timethese':
  James' join+split is the fastest solution, even when the validation in Niels' and my
  solution is removed
=cut

use Data::Validate::IP qw(is_ipv4);

sub defangIP {

    if (is_ipv4($_[0])) {
        $_[0] =~ s/\./[.]/g;
    }
    else {
        print("No valid IP address!");
    }

# Inspired by Niels van Dijke's oneliner which uses the necessary /r switch
# (Niels uses for validation another module Net::IP)
#    (is_ipv4($_[0])) ? $_[0] =~ s/\./[.]/gr : "No valid IP address!";

# James Curtis-Smith solution:
#    join '[.]', split /\./, $_[0];
}

# TESTS
my $ip;

# Example 1
$ip = "1.1.1.1";
print(defangIP($ip), "\n"); # Output: 1[.]1[.]1[.]1

# Example 2
$ip = "255.101.1.0";
print(defangIP($ip), "\n"); # Output: 255[.]101[.]1[.]0

# Example 3
$ip = "123.234.345.001";
print(defangIP($ip), "\n"); # Output: "No valid IP address!

# Example 4
# From: https://metacpan.org/pod/Data::Validate::IP
# There are security implications to this around certain oddly formed addresses.
# Notably, an address like "010.0.0.1" is technically valid, but the operating
# system will treat '010' as an octal number: '010.0.0.1' is interpreted as '8.0.0.1'
# James' solution and Niels' original do not take that into account.
$ip = "010.0.0.1";
print(defangIP($ip), "\n"); # Output: "No valid IP address!
