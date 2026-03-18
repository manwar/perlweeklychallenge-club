#!/usr/bin/env perl

# Perl Weekly Challenge 282 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-282/

use Modern::Perl;

@ARGV==1 or die "Usage: $0 INT\n";
(my $int = shift) =~ /^\d+$/ or die "Usage: $0 INT\n";

if ($int =~ /((\d)\2\2+)/ && length($1) == 3) {
    say $1;
}
else {
    say -1;
}
