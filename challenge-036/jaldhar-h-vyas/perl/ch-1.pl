#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub validateVIN {
    my ($vin) = @_;

    if (length $vin != 17) {
        return undef;
    }

    if ($vin !~ /^
        [[:alnum:]]{3} # World Manufacturer Identifier
        [[:alnum:]]{6} # Vehicle Descriptor Section
        [[:alnum:]]{8} # Vehicle Identifier Section
    $/msx) {
        return undef;
    }

    return 1;
}

say (validateVIN(shift // q{}) ? 'VALID' : 'INVALID');
