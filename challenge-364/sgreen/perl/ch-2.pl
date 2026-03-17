#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ($input_string) {
    if ( $input_string !~ /^(G|\(\)|\(al\))*$/ ) {
        die "Unexpected input received\n;";
    }

    my $output_string = $input_string;
    $output_string =~ s/\(\)/o/g;
    $output_string =~ s/\(al\)/al/g;

    say $output_string;
}


main(@ARGV);