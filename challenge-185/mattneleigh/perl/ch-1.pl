#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @addresses = (
    "1ac2.34f0.b1c2",
    "abc1.20f1.345a"
);

print("\n");
foreach my $address (@addresses){
    printf(
        "Input:  %s\nOutput: %s\n\n",
        $address,
        convert_mac_address($address)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Convert a MAC address from the format XXXX.XXXX.XXXX to XX:XX:XX:XX:XX:XX
# Takes one argument:
# * A MAC address in the format XXXX.XXXX.XXXX
# Returns:
# * The supplied address in the form XX:XX:XX:XX:XX:XX
################################################################################
sub convert_mac_address{

    return(
        join(
            ":",
            map(
                # This will create two list members of
                # two characters each
                m/(..)(..)/,
                split(/\./, shift())
            )
        )
    );

}



