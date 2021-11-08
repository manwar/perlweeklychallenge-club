#!/usr/bin/env perl

use strict;
use warnings;
use feature qw/ say /;

my @integer = ( 101, 18 );

foreach (@integer) {
    my $binary  = sprintf( "%08b", $_ );  # octet
    my $nib1    = substr $binary, 0, 4;
    my $nib2    = substr $binary, 4, 4;
    say oct( "0b" . $nib2 . $nib1 );
}
