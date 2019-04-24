#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;

if ( @ARGV < 1 or @ARGV > 2 )      { die("Provide letters to use and (optionally) filename") }

# To call this application:
#
# perl ch-2.pl <letters> [<filename>]
#
# If you want to use /usr/share/dict/words as the word list, you can
# omit the filename.
#
# Example:
#
#   perl ch-2.pl aet
#
# which is equivilent to:
#
#   perl ch-2.pl eat /usr/share/dict/words
#
# With my Unix dictionary (English), it returns a, e, t, at, ate, eat, eta, and tea.
#

my $match = fc($ARGV[0]);
my %dedupe;

my $filename = $ARGV[1] // '/usr/share/dict/words';
open my $fh, '<', $filename;
while (my $word = <$fh>) {
    chomp($word);
    $word = fc($word);

    my $wordmatch = join '', sort split('', $word);

    if (partialmatch($match, $wordmatch)) {
        next if exists $dedupe{$word};
        $dedupe{$word} = 1;
        say $word;
    }
}

sub partialmatch($chars, $word) {
    my @chars = sort split '', $chars;
    my @word  = sort split '', $word;

    for my $c (@chars) {
        shift(@word) if ($word[0] // ' ') eq $c;
    }
    return ! @word;
}

