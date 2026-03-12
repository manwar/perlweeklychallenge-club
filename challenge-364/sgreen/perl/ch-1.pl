#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ($input_string) {
    if ( $input_string !~ /^(1\d#|2[0-6]#|\d)*$/ ) {
        die "String not in expected format\n";
    }

    my $output_string = $input_string;
    $output_string =~ s/(1\d#|2[0-6]#|\d)/chr(96 + substr($1,0,2))/eg;
    say $output_string;
}

main(@ARGV);
