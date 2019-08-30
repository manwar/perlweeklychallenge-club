#! /usr/bin/env perl

use feature say;

my $string = $ARGV[0] || 'Perl Weekly Challenge';  # [1]

my $count = $string =~ tr/e/E/;                    # [2]

say "$string (with $count replacements).";         # [3]
