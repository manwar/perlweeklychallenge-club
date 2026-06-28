#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ($input_string) {
    my $result_string = "";
    for my $char ( split //, $input_string ) {
        $result_string = $char . $result_string;
    }
    say '"' . $result_string . '"';
}

main(@ARGV);
