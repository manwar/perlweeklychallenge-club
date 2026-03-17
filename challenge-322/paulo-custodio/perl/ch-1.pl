#!/usr/bin/env perl

# Perl Weekly Challenge 322 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-322/

use Modern::Perl;

@ARGV==2 or die "usage: $0 str num\n";
say format_str(@ARGV);

sub format_str {
    my($str, $num) = @_;
    $str =~ s/-//g;
    my @out;
    while (length($str) > $num) {
        unshift @out, substr($str, length($str)-$num);
        $str = substr($str, 0, length($str)-$num);
    }
    unshift @out, $str if $str ne '';
    return join "-", @out;
}
