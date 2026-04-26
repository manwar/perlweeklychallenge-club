#!/usr/bin/perl
use 5.40.1;
use warnings;

my ($paragraph, @banned) = @ARGV;

my %bannedWords = map { lc $_ => 1 } @banned;
my %wordCounts;

for my $word ( split /\W+/, lc $paragraph ) {
    unless (exists $bannedWords{$word}) {
        $wordCounts{$word}++;
    }
}

my $bestWord = '';
my $bestCount = -"Inf";

while (my ($word, $count) = each %wordCounts) {
    if ( $count > $bestCount ) {
        $bestWord = $word;
        $bestCount = $count;
    }
}

say $bestWord;
