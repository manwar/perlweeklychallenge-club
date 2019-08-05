#!/usr/bin/env perl
use v5.22;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;

use List::Util qw(all any max);

my (%states) = map { $_, 1 } qw(
    AK AL AR AZ CA CO CT DE FL GA
    HI IA ID IL IN KS LA MA MD ME
    MI MO MN MS MT NM NC ND NE NH
    NJ NM NV NY OH OK OR PA RI SC
    SD TN TX UT VA VT WA WI WV WY
);

die("Usage: $0 <dictionary file location>") unless @ARGV <= 1;

my $file = $ARGV[1] // '/usr/share/dict/words';

# Read word list
open my $fh, '<', $file;
my @words;
while (my $line = <$fh>) {
    chomp $line;
    push @words, $line;
}
close $fh;

# Get list of all possible candidate words
my @candidates = grep { is_candidate($_) } @words;

# Find maximum word length
my $max = max map { length($_) } @candidates;

# Find the longest one(s) and print them.
say "Longest matches: ", join(" ", grep { length($_) == $max } @candidates);


sub is_candidate($word) {
    # We don't want words that are not some multiple of 2 characters
    # long.
    return if length($word) % 2;

    # We'll use this array for the component parts of the word (the
    # potential state abbreviations), upper casing them.
    my (@parts) = map { uc substr($word, $_*2, 2) } 0..(length($word)/2 - 1);

    # A state abbrevaition can only appear once - and "part" must be a
    # valid state abbreviation.
    my $last = '';
    for my $part (@parts) {
        # Duplicate abbreviation
        return if $part eq $last;

        # Not a state abbreviation
        return if ! exists $states{$part};

        $last = $part;
    }

    return 1;
}


