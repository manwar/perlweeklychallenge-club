#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub nearest_color($hex_string) {
    my %mapping =
      ( 230 => "FF", 179 => "CC", 128 => "99", 77 => "66", 26 => "33", );
    my $value = hex($hex_string);
    foreach my $key ( sort { $b <=> $a } keys %mapping ) {
        if ( $value >= $key ) {
            return $mapping{$key};
        }
    }

    return "00";
}


sub main ($input_string) {
    if ( $input_string !~ /^#[0-9A-F]{6}$/ ) {
        die "Invalid input\n";
    }

    say "#"
      . nearest_color( substr( $input_string, 1, 2 ) )
      . nearest_color( substr( $input_string, 3, 2 ) )
      . nearest_color( substr( $input_string, 5, 2 ) );
}

main(@ARGV);
