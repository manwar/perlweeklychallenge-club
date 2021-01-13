#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my $num = $ARGV[0] || 55;
$num < 1 && die "Invalid input (0)";

my $init = 1;
while (1) {
    my $bin = sprintf "%b", $init++;
    ($bin % $num < 1) && (say $bin) && last
}
=begin
perl .\ch-1.pl 72
111111111000

perl .\ch-1.pl 99
111111111111111111
=cut