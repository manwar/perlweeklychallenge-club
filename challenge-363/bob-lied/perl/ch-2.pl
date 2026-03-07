#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 363 Task 2  Subnet Sheriff
#=============================================================================
# You are given an IPv4 address and an IPv4 network (in CIDR format).
# Write a script to determine whether both are valid and the address falls
# within the network. For more information see the Wikipedia article
# https://en.wikipedia.org/wiki/IPv4
# Example 1 Input: $ip_addr = "192.168.1.45" $domain  = "192.168.1.0/24"
#			Output: true
# Example 2 Input: $ip_addr = "10.0.0.256" $domain  = "10.0.0.0/24"
#			Output: false
# Example 3 Input: $ip_addr = "172.16.8.9" $domain  = "172.16.8.9/32"
#			Output: true
# Example 4 Input: $ip_addr = "172.16.4.5" $domain  = "172.16.0.0/14"
#			Output: true
# Example 5 Input: $ip_addr = "192.0.2.0" $domain  = "192.0.2.0/25"
#			Output: true
#=============================================================================

use v5.42;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================
my @MASK = ( 0x00000000,
             0x00000001, 0x00000003, 0x00000007, 0x0000000f,
             0x0000001f, 0x0000003f, 0x0000007f, 0x000000ff,
             0x000001ff, 0x000003ff, 0x000007ff, 0x00000fff,
             0x00001fff, 0x00003fff, 0x00007fff, 0x0000ffff,
             0x0001ffff, 0x0003ffff, 0x0007ffff, 0x000fffff,
             0x001fffff, 0x003fffff, 0x007fffff, 0x00ffffff,
             0x01ffffff, 0x03ffffff, 0x07ffffff, 0x0fffffff,
             0x1fffffff, 0x3fffffff, 0x7fffffff, 0xffffffff,  );
#=============================================================================

exit(!runTest()) if $DoTest;

say "Netaddr:IP: ", (sheriff(@ARGV) ? "true" : "false");
say "Net::CIDR:  ", (sheriffCIDR(@ARGV) ? "true" : "false");

#=============================================================================
sub sheriff($ip_addr, $domain)
{
    use NetAddr::IP;

    try { 
        my $d  = NetAddr::IP->new( $domain );
        my $ip = NetAddr::IP->new( $ip_addr);
        return $d->contains($ip);
    } catch ( $e ) {
        return false;
    }
}

sub sheriffCIDR($ip_addr, $domain)
{
    use Net::CIDR qw/cidrvalidate cidrlookup/;

    return false unless cidrvalidate($ip_addr) && cidrvalidate($domain);
    return cidrlookup($ip_addr, $domain);
}

sub runTest
{
    use Test2::V0;

    is( sheriff( "192.168.1.45" , "192.168.1.0/24" ),  true, "Example 1");
    is( sheriff( "10.0.0.256"   , "10.0.0.0/24"    ), false, "Example 2");
    is( sheriff( "172.16.8.9"   , "172.16.8.9/32"  ),  true, "Example 3");
    is( sheriff( "172.16.4.5"   , "172.16.0.0/14"  ),  true, "Example 4");
    is( sheriff( "192.0.2.0"    , "192.0.2.0/25"   ),  true, "Example 5");

    is( sheriffCIDR( "192.168.1.45" , "192.168.1.0/24" ),  true, "Example 1");
    is( sheriffCIDR( "10.0.0.256"   , "10.0.0.0/24"    ), false, "Example 2");
    is( sheriffCIDR( "172.16.8.9"   , "172.16.8.9/32"  ),  true, "Example 3");
    is( sheriffCIDR( "172.16.4.5"   , "172.16.0.0/14"  ),  true, "Example 4");
    is( sheriffCIDR( "192.0.2.0"    , "192.0.2.0/25"   ),  true, "Example 5");

    done_testing;
}
