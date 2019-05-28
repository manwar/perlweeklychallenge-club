#!/usr/bin/env perl
use v5.24;
use strict;
use warnings;

#
# Copyright (C) 2019 Joelle Maslak
# All Rights Reserved - See License
#

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use List::Util qw(uniqnum);

while (1) {
    state $num = 99;
    $num++;

    my $square = $num * $num;
    next if (join '', sort split '', $square) ne (join '', uniqnum sort split '', $square);

    say $square;
    exit;
}

