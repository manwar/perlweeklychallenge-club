#!/usr/bin/env perl6
use v6;

# To call this application:
#
# perl6 ch-2.p6 <letters> <filename>
#
# If you want to use /usr/share/dict/words as the word list, you can
# omit the filename.
#
# Example:
#
#   perl6 ch-2.p6 aet
#
# which is equivilent to:
#
#   perl6 ch-2.p6 eat /usr/share/dict/words
#
# With my Unix dictionary (English), it returns a, e, t, at, ate, eat, eta, and tea.
#

sub MAIN(Str:D $letters, Str:D $filename = '/usr/share/dict/words') {
    my $matchbag = Bag.new($letters.comb);
    my SetHash $dedupe = SetHash.new;  # To store matches we gave back

    for $filename.IO.lines -> $word {
        my $fcword = $word.fc;

        my $bag = Bag.new($fcword.comb);

        if $bag ⊆ $matchbag {
            next if $fcword ∈ $dedupe;
            $dedupe{$fcword}++;
            say $fcword;
        }
    }
}

