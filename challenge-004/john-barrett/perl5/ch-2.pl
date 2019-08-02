#!/usr/bin/env perl

use strict;
use warnings;

print "Usage: $0 letters to find in dict\n" and exit unless @ARGV;

my $fn = '/usr/share/dict/words';
my $findletters;
$findletters->{$_}++ for map { map { lc } split '' } @ARGV;

my @found;

open my $fh, '<', $fn;

WORD: while ( my $word = <$fh> ) {
    chomp $word;
    my $wordletters;
    $wordletters->{$_}++ for map { lc } split '', $word;
    # Change this to 'keys %{ $findletters }' to find
    # all words containing the specified letters.
    # This finds all words composed of the specified letters
    # which I think fulfills "you don’t have to use all the letters"
    for my $letter ( keys %{ $wordletters } ) {
        no warnings 'uninitialized';
        next WORD unless $wordletters->{ $letter } <= $findletters->{ $letter };
    }
    push @found, $word;
}

print "$_\n" for @found;
