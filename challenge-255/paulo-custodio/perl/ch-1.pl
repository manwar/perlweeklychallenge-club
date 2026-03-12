#!/usr/bin/env perl

use Modern::Perl;

my($word, $shuffled) = @ARGV;
for my $ch (split //, $word) {
    $shuffled =~ s/$ch//i;
}
say $shuffled;
