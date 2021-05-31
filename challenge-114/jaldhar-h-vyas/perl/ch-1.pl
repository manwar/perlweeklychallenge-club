#!/usr/bin/perl
use 5.020;
use warnings;

my $N = shift // die "Need integer argument\n";

my $next = $N + 1;
do $next++ until $next == reverse $next;
say $next;
