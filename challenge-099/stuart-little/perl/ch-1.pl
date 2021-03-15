#!/usr/bin/perl
use warnings;
use v5.12;

# run <script> <string> <pattern>

use feature qw(signatures);
no warnings qw(experimental::signatures);

my $pat = '^' . (($ARGV[1] =~ s/\*/.*/gr) =~ s/\?/./gr) . '$';
say my $res = (($ARGV[0] =~ /$pat/) ? (1) : (0));
