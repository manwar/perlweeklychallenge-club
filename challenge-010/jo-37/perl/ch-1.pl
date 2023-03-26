#!/usr/bin/perl -s

use v5.16;
use warnings;
use Roman;

main: {
    my $input = shift;
    say isroman($input) ? arabic($input) : Roman($input);
}
