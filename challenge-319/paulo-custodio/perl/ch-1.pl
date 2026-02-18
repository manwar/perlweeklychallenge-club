#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 words...\n";
say scalar grep {match($_)} @ARGV;

sub match {
    my($word) = @_;
    return 1 if /^[aeiou]/i;
    return 1 if /[aeiou]$/i;
    return 0;
}
