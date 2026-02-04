#!/usr/bin/env perl

use Modern::Perl;

@ARGV==1 or die "usage: $0 string\n";
say strings_alike($ARGV[0]) ? 'true' : 'false';

sub strings_alike {
    my($str) = @_;
    my $mid = int(length($str) / 2);
    my $s1 = substr($str, 0, $mid);
    my $s2 = substr($str, $mid);
    return 0 if length($s1) != length($s2);
    my $n1 = num_vowels($s1);
    my $n2 = num_vowels($s2);
    return $n1 > 0 && $n1 == $n2;
}

sub num_vowels {
    my($str) = @_;
    return $str =~ tr/aeiouAEIOU/aeiouAEIOU/;
}
