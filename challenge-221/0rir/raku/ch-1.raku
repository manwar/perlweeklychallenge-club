#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
221-1: Good Strings             Submitted by: Mohammad S Anwar
Given a list of @words and a string $chars.  A string is good if it can
be formed by characters from $chars, each character can be used only once.

Write a script to return the sum of lengths of all good strings in words.

Example 1
Input: @words = ("cat", "bt", "hat", "tree")
       $chars = "atach"
Output: 6

The good strings that can be formed are "cat" and "hat" so the answer is 3 + 3 = 6.
Example 2
Input: @words = ("hello", "world", "challenge")
       $chars = "welldonehopper"
Output: 10

The strings that can be formed are "hello" and "world" so the answer is 5 + 5 = 10.

=end comment

my @Test =
        # candidate-words             alphabet        solut-chars
    ("cat", "bt", "hat", "tree"),    "atach",               6,
    ("hello", "world", "challenge"), "welldonehopper",     10,
    ("hello", "world", "challenge"), "r",                   0,
    ("hello", "world", "challenge"), "",                    0,
    ("at", "chat", "cat", "act", 'hat', 'attach'),
                                    "atach",               15, 
    (),                              'r',                   0,
    (),                              '',                    0,
;
my @Dead =
    List,                           "atach",                0,
    ("hello", "world", "challenge"), Str,                   0,
;

plan (@Test + @Dead) ÷ 3;

sub good-word( Any:D $alphabet, @candi -->Array) {
    # Possible optimiz:  ignore candidate words longer than alphabet str.
    my ( %allowed, @good-word);
    for $alphabet.comb {
        ++ %allowed{$_}
    }
    WORD: for @candi -> $c {
        my %got;
        for $c.comb {
            quietly if ++ %got{$_} > %allowed{$_} {
                next WORD;
            }
        }
        @good-word.push: $c;
    }
    return @good-word;
}

for @Test -> @word, $alphabet, $exp {
    is good-word($alphabet, @word).join.chars, $exp, 'good-word combined lgth';
}
for @Dead -> @word, $alphabet, $exp {
    dies-ok { good-word($alphabet, @word)}, 'dies';
}
done-testing;

my @word  = ("at", "chat", "cat", "act", 'hat', 'attach');
my $chars = "atach";
say "\nInput: @word  = @word.raku()\n       \$chars = $chars.raku()\n"
~ "Output: ", good-word( $chars, @word).join.chars;
