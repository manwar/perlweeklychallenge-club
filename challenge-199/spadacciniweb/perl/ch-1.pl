#!/usr/bin/env perl
use strict;
use warnings;

my @list = @ARGV;
die 'list elements < 2'
    if scalar @list < 2;

my $output = 0;
foreach my $i (0..$#list-1) {
    $output += scalar map { $list[$i] == $list[$_] ? 1 : () }
                        ($i+1..$#list);
}
printf 'Output: %s', $output;
