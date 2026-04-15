#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ($input_string) {
    # Remove excess characters
    $input_string =~ s/[^\sa-zA-Z]//g;

    # Remove leading and trailing whitespace
    $input_string =~ s/^\s+//;
    $input_string =~ s/\s+$//;

    # Convert the string to lower case, and capitalize subsequent words
    $input_string = lc $input_string;
    $input_string =~ s/ +([a-z])/uc $1/eg;

    # Display tag
    say "#" . substr($input_string, 0, 99);
}

main(@ARGV);