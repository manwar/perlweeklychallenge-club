#!/usr/bin/env perl

# Perl Weekly Challenge 221 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-221/

use Modern::Perl;

my @words = @ARGV;
my $chars = pop(@words);
my $result = 0;
for my $word (@words) {
    $result += length($word) if is_good_string($word, $chars);
}
say $result;

sub is_good_string {
    my($word, $chars) = @_;
    for my $ch (split //, $chars) {
        $word =~ s/$ch//i;
    }
    return $word eq '';
}
