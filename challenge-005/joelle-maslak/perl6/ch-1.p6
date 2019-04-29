#!/usr/bin/env perl6
use v6;

# To call this application:
#
# perl6 ch-1.p6 <letters> <filename>
#
# If you want to use /usr/share/dict/words as the word list, you can
# omit the filename.
#
# Example:
#
#   perl6 ch-1.p6 binary
#
# which is equivilent to:
#
#   perl6 ch-1.p6 binary /usr/share/dict/words
#
# With my Unix dictionary (English), it returns binary and brainy
#
# Yes, this is a VERY tiny modification of Week 4 problem 2.
#

sub MAIN(Str:D $letters, Str:D $filename = '/usr/share/dict/words') {
    my $matchbag = Bag.new($letters.comb);
    my SetHash $dedupe = SetHash.new;  # To store matches we gave back

    for $filename.IO.lines -> $word {
        my $fcword = $word.fc;

        my $bag = Bag.new($fcword.comb);

        if $bag ~~ $matchbag {
            next if $fcword ∈ $dedupe;
            $dedupe{$fcword}++;
            say $fcword;
        }
    }
}

