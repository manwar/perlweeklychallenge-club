#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Net::IP;

sub main ( $ip_addr, $domain ) {
    my $addr  = Net::IP->new($ip_addr);
    my $block = Net::IP->new($domain);
    if ( $addr and $block ) {
        # Check if $addr in $block
        my $overlaps = ( $addr->overlaps($block) != $IP_NO_OVERLAP );
        say $overlaps ? 'true' : 'false';
    }
    else {
        # If a IP address is not valid, return false
        say 'false';
    }
}


main(@ARGV);