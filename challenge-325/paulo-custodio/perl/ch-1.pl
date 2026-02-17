#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw(max);

@ARGV or die "usage: $0 bin...\n";
my $bin = join '', @ARGV;
my $max = 0;
while ($bin =~ /1+/g) {
    $max = max($max, length($&));
}
say $max;
