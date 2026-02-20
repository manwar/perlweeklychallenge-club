#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 words...\n";

my @anagrams = find_anagrams(@ARGV);
say scalar(@anagrams);

sub is_anagram {
    my($word1, $word2) = @_;
    $word1 = join '', sort split //, $word1;
    $word2 = join '', sort split //, $word2;
    return $word1 eq $word2;
}

sub find_anagrams {
    my(@words) = @_;
    for (my $i = 0; $i < $#words; $i++) {
        while ($i < $#words && is_anagram($words[$i], $words[$i+1])) {
            splice(@words, $i, 1);
        }
    }
    return @words;
}
