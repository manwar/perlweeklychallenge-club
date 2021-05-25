#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script> <number>

use feature qw(signatures);
no warnings qw(experimental::signatures);

say "Initial number in base two: ", my $binNr = sprintf("0%b", $ARGV[0]);
say "Next number in base two: ", my $next = (($ARGV[0] % 2) ? ($binNr =~ s!01(1*)$!10$1!r) : ($binNr =~ s!01(1*)(0*)$!10$2$1!r));
say "Next number in base ten: ", eval qq!0b$next!;
