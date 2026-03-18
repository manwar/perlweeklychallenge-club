#!/usr/bin/env perl

# Perl Weekly Challenge 295 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-295/

use Modern::Perl;
@ARGV>2 or die "usage: $0 string words...\n";
my($string, @words) = @ARGV;
say word_break($string, @words) ? "true" : "false";

sub word_break {
    my($string, @words) = @_;
    while ($string ne '') {
        my $found;
        for my $word (@words) {
            if (substr($string, 0, length($word)) eq $word) {
                $string = substr($string, length($word));
                $found = 1;
                last;
            }
        }
        return unless $found;
    }
    return 1;
}
