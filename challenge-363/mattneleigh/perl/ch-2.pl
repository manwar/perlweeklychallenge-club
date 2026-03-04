#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @ip_addresses = (
    [
        "192.168.1.45",
        "192.168.1.0/24"
    ],
    [
        "10.0.0.256",
        "10.0.0.0/24"
    ],
    [
        "172.16.8.9",
        "172.16.8.9/32"
    ],
    [
        "172.16.4.5",
        "172.16.0.0/14"
    ],
    [
        "192.0.2.0",
        "192.0.2.0/25"
    ]
);

print("\n");
foreach my $ip_address (@ip_addresses){
    printf(
        "Input: \$ip_addr = \"%s\"\n"
            . "       \$domain  = \"\%s\"\nOutput: %s\n\n",
        $ip_address->[0],
        $ip_address->[1],
        validate_network_address(@{$ip_address}) ? "true" : "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether an IP address and a network specification in CIDR format
# are valid, and whether the IP address is part of the specified network
# Takes two arguments:
# * A string consisting of the IP address to examine (e.g. "10.0.0.256")
# * A string consisting of the CIDR-formatted IP address and the number of bits
#   that should be taken as the network prefix (e.g. "10.0.0.0/24")
# Returns:
# * 1 if the IP address and CIDR spec appear to be valid and the IP address is
#   a valid part of the CIDR network described
#   described
# * 0 if the IP address or CIDR spec do NOT appear to be valid or the IP
#   address is NOT a valid part of the CIDR network described (as would be the
#   case in the example above)
################################################################################
sub validate_network_address{
    my $ip = shift();
    my $cidr = shift();
    
    my $bits;
    my $ip_bitwise = 0x00000000;
    my $cidr_bitwise = 0x00000000;
    my $shift = 24;

    # Remove the bit prefix specification from
    # the CIDR block, and make a bit mask
    # equivalent to it
    $cidr =~ s/\/(\d+)$//;
    return(0)
        if(($1 < 0) || ($1 > 32));
    $bits = 0x00000000 | ((2 ** $1) - 1 ) << (32 - $1);

    # Convert the IP address and CIDR block (less
    # the prefix spec) into single corresponding
    # integers; also check for the correct
    # quantity of the correct values en passant
    foreach (split(/\./, $ip)){
        return(0)
            if(($_ < 0) || ($_ > 255));
        $ip_bitwise |= $_ << $shift;
        $shift -= 8;
    }
    return(0)
        if($shift != -8);

    $shift = 24;
    foreach (split(/\./, $cidr)){
        return(0)
            if(($_ < 0) || ($_ > 255));
        $cidr_bitwise |= $_ << $shift;
        $shift -= 8;
    }
    return(0)
        if($shift != -8);

    return(
        # Determine whether the masked bits of the IP
        # address and the CIDR network are equal
        ($ip_bitwise & $bits) == ($cidr_bitwise & $bits) ?
            1
            :
            0
    );

}



