#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use autodie;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(first);

say smallest_positive_number_missing(@ARGV);

sub smallest_positive_number_missing( @xs) {
    my %lookup = map { $_ => 1 } @xs;
    return first { !$lookup{$_} } 1 .. ( @xs + 1 );
}

