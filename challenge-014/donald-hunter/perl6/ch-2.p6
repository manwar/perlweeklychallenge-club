use v6;

my %states = (.split(/\t/)[0,5] for 'us-abbrevs.txt'.IO.lines).flat.map: -> $a, $b { $b.lc => $a };
my @words = '/usr/share/dict/words'.IO.lines.grep: *.chars %% 2;
say "Searching {+@words} words";

sub reduce(@words, Int $pos = 0) {
    my @candidates = @words.grep: { %states{.substr($pos, 2)}:exists };
    if +@candidates {
        reduce(@candidates, $pos + 2);
    } else {
        @words;
    }
}

my @longest = reduce(@words);
say %states{.comb(/\w\w/)}.join(' '), ' -> ', .Str, ' (', .chars, ')' for @longest;
