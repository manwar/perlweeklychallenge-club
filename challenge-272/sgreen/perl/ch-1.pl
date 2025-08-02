#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($ip) {
    $ip =~ s/\./[.]/g;
    say $ip;
}

main($ARGV[0]);