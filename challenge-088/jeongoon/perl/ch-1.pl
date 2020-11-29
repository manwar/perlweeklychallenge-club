#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use strict; use warnings;
use v5.26;

use List::Util qw(product);
use Scalar::Util qw(looks_like_number);

my @n = grep {looks_like_number $_ and $_ > 0} @ARGV;

warn "some value ignored." if scalar @ARGV != scalar @n;

my $p = product @n;

say "[",
    join( ",",
          map { $p / $_ } @n ),
    "]";
