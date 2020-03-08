#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my @list = sort {$a - $b } split " ",$ARGV[0] || "2 6 1 3";

for my $i (0..~-@list) {
    say $list[$i] if ~-@list-$i == $list[$i]
}
=begin
perl .\ch-2.pl "2 6 1 3"
2
=cut 