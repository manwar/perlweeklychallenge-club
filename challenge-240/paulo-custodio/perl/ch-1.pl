#!/usr/bin/env perl

# Perl Weekly Challenge 240 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-240/

use Modern::Perl;

# parse args
sub usage { return "Usage: $0 -str s1 s2 s3 ... -chk check\n"; }

my(@strs, $check);
while (@ARGV) {
    if ($ARGV[0] eq "-str") {
        shift;
        while (@ARGV && $ARGV[0] !~ /^-/) {
            push @strs, shift;
        }
    }
    elsif ($ARGV[0] eq "-chk") {
        shift;
        $check = shift;
    }
    else {
        die usage();
    }
}
if (!@strs || !$check) { die usage(); }

# compute
my $inits = join '', map { substr($_,0,1) } @strs;

# output
if (lc($inits) eq lc($check)) {
    say "true";
}
else {
    say "false";
}
