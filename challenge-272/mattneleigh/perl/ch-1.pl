#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @addresses = (
    "1.1.1.1",
    "255.101.1.0"
);

print("\n");
foreach my $address (@addresses){
    printf(
        "Input: \$ip = \"%s\"\nOutput: \"%s\"\n\n",
        $address,
        defanged_address_from_ip($address)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Produce a defanged version of an IPv4 address- that is to say, one in which
# every '.' is replaced with '[.]'
# Takes one argument:
# * A string that contains an IPv4 address (e.g. "1.1.1.1")
# Returns:
# * The defanged IP address (e.g. "1[.]1[.]1[.]1")
################################################################################
sub defanged_address_from_ip{
    my $addr = shift();

    # Just substitute every period for a bracketed
    # period.  Easy.
    $addr =~ s/\./[.]/g;

    return($addr);

}



