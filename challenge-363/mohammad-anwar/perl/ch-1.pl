#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Lingua::EN::Words2Nums;

my %examples = (
    "aa — two vowels and zero consonants"     => "true",
    "iv — one vowel and one consonant"        => "true",
    "hello - three vowels and two consonants" => "false",
    "aeiou — five vowels and zero consonants" => "true",
    "aei — three vowels and zero consonants"  => "true",
);

is lie_detector($_), $examples{$_} for keys %examples;

done_testing;

sub lie_detector {
    my $str = shift;

    my ($word) = $str =~ /^([^-—]+)/;
    $word =~ s/\s+$//;

    my $vow = () = $word =~ /[aeiou]/gi;
    my $con = () = $word =~ /[b-df-hj-np-tv-z]/gi;

    my ($v_phrase, $c_phrase) = $str =~ /([\w\s]+?)\s+vowels?.*?([\w\s]+?)\s+consonants?/;

    if (defined $v_phrase && defined $c_phrase) {
        $v_phrase =~ s/^\s+|\s+$//g;
        $c_phrase =~ s/^\s+|\s+$//g;

        my $v_claim = words2nums($v_phrase);
        my $c_claim = words2nums($c_phrase);

        return (defined $v_claim && defined $c_claim &&
                $v_claim == $vow && $c_claim == $con) ? "true" : "false";
    }

    return "false";
}
