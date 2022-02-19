#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use List::Util qw(min sum);
use JSON;


sub main {
    # Read the input
    my $triangle = decode_json(shift);
    say sum(map { min @$_ } @$triangle);
}

main(@ARGV);