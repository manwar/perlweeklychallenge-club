#!/usr/bin/env perl

# Perl Weekly Challenge 274 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-274/

use Modern::Perl;

say join ' ', map{goat_latin($ARGV[$_], $_)} 0 .. $#ARGV;

sub goat_latin {
    my($word, $i) = @_;
    if ($word =~ /^[aeiou]/i) {
        $word .= "ma";
    }
    else {
        my $ch = substr($word,0,1);
        $word = substr($word,1).$ch."ma";
    }
    $word .= "a" x ($i+1);
    return $word;
}
