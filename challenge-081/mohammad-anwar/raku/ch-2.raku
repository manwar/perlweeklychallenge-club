#!/usr/bin/env raku

#
# Perl Weekly Challenge - 081
#
# Task #2: Frequency Count
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-081
#

use v6.d;

sub MAIN(Str :$file where *.IO.f) {
    frequency-count(fetch-words($file));
}

#
#
# SUBROUTINES

sub fetch-words(Str $file where *.IO.f) {

    my $words;
    for $file.IO.lines -> $line is copy {
        $line ~~ s:g/\.//;
        $line ~~ s:g/\"//;
        $line ~~ s:g/\(//;
        $line ~~ s:g/\)//;
        $line ~~ s:g/\,//;
        $line ~~ s:g/\'s//;
        $line ~~ s:g/\-\-/ /;
        for $line.split(" ") -> $word {
            $words.{$word} += 1;
        }
    }

    return $words;
}

sub frequency-count($words) {

    my %frequency = ();
    for $words.keys -> $word {
        %frequency{$words.{$word}}.push: $word;
    }

    for %frequency.keys.sort({ $^a <=> $^b }) -> $count {
        ($count, %frequency{$count}.sort).join(" ").say;
    }
}
