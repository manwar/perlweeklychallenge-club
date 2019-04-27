#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;

if ( @ARGV > 1 )      { die("Provide (optionally) filename and nothing else") }

# To call this application:
#
# perl ch-2.pl <filename>
#
# If you want to use /usr/share/dict/words as the word list, you can
# omit the filename.
#
# Example:
#
#   perl ch-2.pl
#
# which is equivilent to:
#
#   perl ch-2.pl /usr/share/dict/words
#
# With my Unix dictionary (English), it returns teals

my $filename = $ARGV[0] // '/usr/share/dict/words';

my %wordseen;
my %wordcache;
my $maxcnt = 0;
my $maxword = '';

open my $fh, '<', $filename;
while (my $word = <$fh>) {
    chomp($word);
    $word = fc($word);
    next if (exists $wordseen{$word});  # We do not consider a change in case an anagram
    $wordseen{$word} = 1;

    my $matchkey = join '', sort split '', $word;
    my $cnt = ($wordcache{$matchkey} // 0) + 1;
    $wordcache{$matchkey} = $cnt;

    if ($cnt > $maxcnt) {
        $maxcnt = $cnt;
        $maxword = $word;
    } elsif ($cnt == $maxcnt) {
        $maxword = "$maxword | $word";  # For where TWO OR MORE words have same # of anagrams
    }
}

say "Best sequence ($maxcnt anagrams): $maxword";

