#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use English qw/ -no_match_vars /;

sub usage {
    print <<"-USAGE-";
    Usage:
    $PROGRAM_NAME <list>

    <list>       List of words to search for anagrams.
-USAGE-

    exit(1);
}

if (scalar @ARGV < 1) {
    usage();
}

my $list = $ARGV[0];

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

my @keys =
    reverse
    sort { scalar @{ $anagrams{$a} } <=> scalar @{ $anagrams{$b} } }
    keys %anagrams;

say join q{ }, sort @{ $anagrams{$keys[0]} };
