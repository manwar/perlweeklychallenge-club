use strict;
use warnings;

use v5.38;

my @inputs = (
    'a1c1e1',
    'a1b2c3d4',
    'b2b',
    'a16z',
    );

for (@inputs) {
    say $_ . ' ' . replace_digits($_);
}

sub replace_digits ( $string ) {
    $string =~ s/^\d+//; # strip any leading digits
    $string =~ s/
    	       (\D)(\d+) # a non-digit followed by one or more digits
    	       /
	       $1 . join '', map {chr( ord( $1 ) + $_ )} split '', $2
	       /gex;

    return $string;
}
