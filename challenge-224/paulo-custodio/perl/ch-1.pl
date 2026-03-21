#!/usr/bin/env perl

# Perl Weekly Challenge 224 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-224/

use Modern::Perl;

@ARGV==2 or die "Usage: $0 source target\n";
my($source, $target) = @ARGV;

say can_make_string($target, $source) ? "true" : "false";

sub can_make_string {
    my($str, $chars) = @_;
    for my $ch (split //, $chars) {
        $str =~ s/$ch//i;
    }
    return $str eq '';
}
