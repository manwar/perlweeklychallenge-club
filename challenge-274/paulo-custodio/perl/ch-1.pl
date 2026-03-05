#!/usr/bin/env perl

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
