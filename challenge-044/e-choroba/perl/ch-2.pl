#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

my %possibilities = (1 => []);
while (! exists $possibilities{200}) {
    my %next;
    for my $p (keys %possibilities) {
        $next{ $_ } = [ @{ $possibilities{$p} }, $p ]
            for $p + 1, $p * 2;
    }
    %possibilities = %next;
}

my @moves = @{ $possibilities{200} };
say scalar @moves, ": @moves";
