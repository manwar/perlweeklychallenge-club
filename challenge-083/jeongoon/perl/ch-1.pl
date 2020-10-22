#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use strict; use warnings;
use v5.26;

use List::Util qw(sum);

sub usage {
    say 'Usage: perl ch-1.pl <a string with 3 or more words>', "\n",
        'ex) perl ch-1.pl "Perl Weekly Challenge"';
}

package main;

my @words;

@ARGV == 1 or usage, exit 1;
@words = split /\s/, $ARGV[0];
@words > 2 or usage, exit 2;

say(
    sum
    map {length}        # count each length
    @words[
           1            # from the second word
           ..
            $#words-1   # to   the second last one
          ]
   );
