#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main (@array) {
    my $prefix = pop(@array);
    my $count  = grep { substr( $prefix, 0, length($_) ) eq $_ } @array;
    say $count;
}

main(@ARGV);
