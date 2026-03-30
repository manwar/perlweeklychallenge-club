#!/usr/bin/env perl

# Perl Weekly Challenge 186 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-186/

use Modern::Perl;
use Text::Unidecode;
use Path::Tiny;

open(my $in, "<:utf8", "ch-2.in") or die "open ch-2.in: $!\n";
open(my $out, ">:raw", "ch-2.out") or die "open ch-2.out: $!\n";

while (<$in>) {
    $_ = unidecode($_);
    print $out $_;
}

close($in);
close($out);

if (path("ch-2.out")->slurp_raw eq path("ch-2.exp")->slurp_raw) {
    say "ok";
    unlink "ch-2.out";
}
else {
    say "not ok";
}
