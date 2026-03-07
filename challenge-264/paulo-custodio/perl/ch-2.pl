#!/usr/bin/env perl

use Modern::Perl;

my($source, $indices) = split /,/, "@ARGV";
my @source = split ' ', $source;
my @indices = split ' ', $indices;

my @result;
for (0 .. $#source) {
    splice(@result, $indices[$_], 0, $source[$_]);
}

say "(", join(", ", @result), ")";
