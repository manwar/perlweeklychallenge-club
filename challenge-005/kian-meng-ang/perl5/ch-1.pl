#!/usr/bin/env perl

use 5.010;
use autodie;
use strict;
use warnings;
use utf8;
use Carp;

carp 'missing word and dictionary file' if (@ARGV != 2);
my ($word, $dict) = @ARGV;
my $word_hash = join '', sort split //, $word;
my $word_length = length $word_hash;
my @anagrams;

open my $fh, '<:encoding(UTF-8)', $dict;
while (my $dword = <$fh>) {
    chomp $dword;
    next if (length $dword != $word_length);

    my $dword_hash = join '', sort split //, $dword;
    next if ($dword_hash ne $word_hash);
    next if ($dword eq $word);

    push @anagrams, $dword;
}
close $fh;

say sprintf 'Word: %s', $word;
say sprintf 'Anagrams: %s', join q|, |, @anagrams;

1;

__END__

$ perl ch-1.pl elbow /usr/share/dict/words
Word: elbow
Anagrams: below, bowel

# vi:et:sw=4 ts=4 ft=perl
