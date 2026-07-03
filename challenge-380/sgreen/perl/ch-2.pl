#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use List::Util 'sum';

sub main ($input_string) {
    if ( $input_string !~ /^[a-zA-Z]*$/ ) {
        die "String must only contain English letters\n";
    }

    my @numbers = map { ord("z") - ord($_) + 1 } split //, lc $input_string;
    my $pos     = 0;
    say sum( map { $_ * ++$pos } @numbers );
}

main(@ARGV);
