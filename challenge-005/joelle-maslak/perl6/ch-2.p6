#!/usr/bin/env perl6
use v6;

# To call this application:
#
# perl6 ch-2.p6 <filename>
#
# If you want to use /usr/share/dict/words as the word list, you can
# omit the filename.
#
# Example:
#
#   perl6 ch-2.p6
#
# which is equivilent to:
#
#   perl6 ch-2.p6 /usr/share/dict/words
#
# With my Unix dictionary (English), it returns teals
#

sub MAIN(Str:D $filename = '/usr/share/dict/words') {
    my %wordseen;
    my %wordcache;
    my $maxcnt = 0;
    my $maxword = '';

    for $filename.IO.lines -> $word {
        next if %wordseen{$word.fc}:exists;  # We do not consider a change in case an anagram
        %wordseen{$word.fc} = 1;

        my $matchkey = $word.fc.comb.sort.join('');
        my $cnt = (%wordcache{$matchkey} // 0) + 1;
        %wordcache{$matchkey} = $cnt;

        if $cnt > $maxcnt {
            $maxcnt = $cnt;
            $maxword = $word;
        } elsif $cnt == $maxcnt {
            $maxword = "$maxword | $word";  # For where TWO OR MORE words have same # of anagrams
        }
    }
    
    say "Best sequence ($maxcnt anagrams): $maxword";
}

