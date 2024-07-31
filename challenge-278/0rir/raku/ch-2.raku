#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
278 2: Reverse Word         Submitted by: Mohammad Sajid Anwar

Given a word, $word and a character, $char.  Replace the substring up
to and including $char with its characters sorted alphabetically. If
the $char doesn’t exist then DON'T do anything.  

Example 1
Input: $str = "challenge", $char = "e"
Ouput: "acehllnge"
Example 2
Input: $str = "programming", $char = "a"
Ouput: "agoprrmming"
Example 3
Input: $str = "champion", $char = "b"
Ouput: "champion"

=end comment

my @Test =
#      word             char  exp
    'a',                'x',    'a',
    'a',                'a',    'a',
    'ab',               'a',    'ab',
    'ba',               'a',    'ab',
    'abc',              'a',    'abc',
    'bac',              'a',    'abc',
    'abc',              'b',    'abc',
    'abc',              'c',    'abc',
    "challenge",        "e",    "acehllnge",
    "programming",      "a",    "agoprrmming",
    "champion",         "b",    "champion",
    'edcba',            'a',    'abcde',
;

my @Die =   Str,    'a',
            Any,    'a',
            '',     'a';

plan @Test ÷ 3 + @Die ÷ 2;


multi task( Any:D $w where * ~~ / ^ <:L>+ $ / ,
            Any:D $char where *.chars == 1 -->Str:D) {
    my @a = $w.comb;
    my $k = ( return $w ) R// @a.first( $char, :k);
    my @head = @a[0..$k].sort: *.fc;
    return @head.join unless @a[$k + 1] :exists;
    #@head.join ~ @a[$k+1 .. *].join;
    ( @head, @a[$k+1 .. *]).flat.join;
}

for @Test -> $w, $c, $exp {
    is task($w, $c), $exp, "$exp.raku() <<- $c.raku() <∘~ $w.raku()";
}
for @Die -> $w, $c {
    dies-ok { task $w, $c}, "Dead <<- $c.raku() <∘~ $w.raku()";
}
done-testing;

my $str = 'Anotherusefulquiz';
my $char = 'l';
say qq{\nInput:  \$str = $str.raku(), \$char = $char.raku()\n}
  ~ qq{Output: &task( $str, $char).raku()};

