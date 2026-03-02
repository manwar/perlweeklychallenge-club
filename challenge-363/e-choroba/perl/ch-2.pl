#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use NetAddr::IP;

sub subnet_sheriff($ip_addr, $domain) {
    $ip_addr = 'NetAddr::IP'->new($ip_addr) or return;
    $domain = 'NetAddr::IP'->new($domain) or return;

    return $ip_addr->within($domain)
}

use Test2::V0;
use constant {true => bool(1), false => bool(0)};

plan(5 + 2);

is subnet_sheriff('192.168.1.45', '192.168.1.0/24'), true, 'Example 1';
is subnet_sheriff('10.0.0.256', '10.0.0.0/24'), false, 'Example 2';
is subnet_sheriff('172.16.8.9', '172.16.8.9/32'), true, 'Example 3';
is subnet_sheriff('172.16.4.5', '172.16.0.0/14'), true, 'Example 4';
is subnet_sheriff('192.0.2.0', '192.0.2.0/25'), true, 'Example 5';

is subnet_sheriff('1.1.1.1', '1.2.0.0/15'), false, 'Mask not matching';
is subnet_sheriff('1.1.1.256', '1.2.0.0/14'), false, 'Invalid IP';
