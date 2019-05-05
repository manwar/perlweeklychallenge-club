#!/usr/bin/env perl

use 5.010;
use autodie;
use strict;
use warnings;
use utf8;
use Carp;
use List::Util qw(max);

carp 'missing dictionary file' if (@ARGV != 1);
my ($dict) = @ARGV;
my %anagram_list;

open my $fh, '<:encoding(UTF-8)', $dict;
while (my $dword = <$fh>) {
    chomp $dword;

    my $dword_hash = join '', sort split //, $dword;
    push @{ $anagram_list{$dword_hash} }, $dword;
}
close $fh;

my $max_anagram_count = max(map { scalar @{$_} } values %anagram_list);

foreach my $anagrams (values %anagram_list) {
    next if (scalar @{$anagrams} != $max_anagram_count);
    say sprintf 'Total anagrams: %d', scalar @{$anagrams};
    say sprintf 'Anagrams: %s', join q|, |, @{$anagrams};
    say q||;
}

1;

__END__

$ perl ch-2.pl /usr/share/dict/words
Total anagrams: 7
Anagrams: carets, caster, caters, crates, reacts, recast, traces

Total anagrams: 7
Anagrams: pares, parse, pears, rapes, reaps, spare, spear

# vi:et:sw=4 ts=4 ft=perl
