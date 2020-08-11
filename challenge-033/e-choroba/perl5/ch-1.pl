#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

my %count;
while (<>) {
    $count{ lc $1 }++ while /([a-zA-Z])/g;
}
for my $char (sort keys %count) {
    say "$char: $count{$char}";
}
