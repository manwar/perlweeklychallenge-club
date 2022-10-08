#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

my @addresses = qw{
    1ac2.34f0.b1c2
    abc1.20f1.345a
};

for my $i (@addresses) {
    my $o = mac_addr_conversion($i);
    say <<"END";
        Input:  $i
        Output: $o
END
}

sub mac_addr_conversion ($input) {
    $input = lc $input;
    $input =~ s/\.//gmx;
    return join ':', grep { length > 0 } split( /(..)/, $input );
}
