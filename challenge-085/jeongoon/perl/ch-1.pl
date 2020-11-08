#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use strict; use warnings;
use v5.32;      # for syntax: a < x < b

use Algorithm::Combinatorics qw(combinations);
use List::Util qw(sum);

sub tidyList(@) {
    sort                # as we will try from lowest sum of a group
      grep { $_ < 2.0 } # as x >= 2.0 is not useful here
      @_;

}

@ARGV > 2 or die "Need at least 3 real numbers!";

my @list = tidyList @ARGV;
my $it = combinations( \@list, 3 );

{
    local $" = " + ";
    # take combination of triplet one by one
    while ( my $triplet = $it->next() ) {
        my $ts = sum @$triplet;
        if ( 1.0 < $ts < 2.0 ) {
            say "1.0 < ( @$triplet == $ts ) < 2.0";
            exit 0;
        }
    }
}

say "0";
exit 1;
