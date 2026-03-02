#!/usr/bin/env perl

use Modern::Perl;

@ARGV==1 or die "usage: $0 string\n";
my $str = shift;

my($word, $description) = split(/\s*-\s*/, $str, 2);
my($want_vowels, $want_consonants) = parse_nl($description);
my($have_vowels, $have_consonants) = count_word($word);
my $ok = ($want_vowels == $have_vowels) && ($want_consonants == $have_consonants);
say $ok ? "true" : "false";

sub parse_nl {
    my($str) = @_;
    $str = lc($str);

    for ($str) {
        s/\b zero  \b/0/gx;
        s/\b one   \b/1/gx;
        s/\b two   \b/2/gx;
        s/\b three \b/3/gx;
        s/\b four  \b/4/gx;
        s/\b five  \b/5/gx;
        s/\b six   \b/6/gx;
        s/\b seven \b/7/gx;
        s/\b eight \b/8/gx;
        s/\b nine  \b/9/gx;
        s/\b ten   \b/10/gx;
    }

    my($vowels) = $str =~ /(\d+) \s+ vowel/xi;
    $vowels //= 0;

    my($consonants) = $str =~ /(\d+) \s+ consonant/xi;
    $consonants //= 0;

    return ($vowels, $consonants);
}

sub count_word {
    my($word) = @_;
    $word = lc($word);

    my $vowels = $word =~ tr/aeiou/...../;
    $word =~ s/[^a-z]//g;
    my $consonants = length($word);

    return ($vowels, $consonants);
}
