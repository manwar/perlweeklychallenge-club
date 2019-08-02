#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use English qw/ -no_match_vars /;

sub usage {
    print <<"-USAGE-";
    Usage:
    $PROGRAM_NAME <word> <list>

    <word>       Find anagrams for this word.
    <list>       List of words to search for anagrams.
-USAGE-

    exit(1);
}

if (scalar @ARGV < 2) {
    usage();
}

my $word = $ARGV[0];
my $list = $ARGV[1];
my $search = join q{}, sort split //, $word;

open my $wordList, '<', $list or die "$list: $!\n";
local $RS;
my $contents = <$wordList>;
close $wordList;
my @words = split /\n/, $contents;

my %dictionary;
foreach my $word (@words) {
    $dictionary{$word} = join q{}, sort split //, $word;
}

my %anagrams;
foreach my $key (keys %dictionary) {
    push @{ $anagrams{$dictionary{$key}} }, $key;
}

if (exists $anagrams{$search}) {
    say join q{ }, sort grep { $_ ne $word } @{ $anagrams{$search} };
}
