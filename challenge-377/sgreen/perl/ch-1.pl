#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ($input_string) {
    my $reversed_string = reverse($input_string);
    foreach my $start_pos ( 0 .. length($input_string) - 2 ) {
        if (
            index( $input_string, substr( $reversed_string, $start_pos, 2 ) )
            != -1 )
        {
            say "true";
            return;
        }
    }

    say "false";
}

main(@ARGV);
