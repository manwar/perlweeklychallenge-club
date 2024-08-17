#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
280-2: Count Asterisks      Submitted by: Mohammad Sajid Anwar
        REPHASED
Given a string, $str, where two consecutive vertical bars group the chars
between them; a bar can only pair with one or none other bar.
Return the number of asterisks, *, which are not within such pairs.

Example 1
Input: $str = "p|*e*rl|w**e|*ekly|"
Ouput: 2

The characters we are looking here are "p" and "w**e".
Example 2
Input: $str = "perl"
Ouput: 0
Example 3
Input: $str = "th|ewe|e**|k|l***ych|alleng|e"
Ouput: 5

The characters we are looking here are "th", "e**", "l***ych" and "e".
=end comment

my @Test =
    # str       exp
    '',            0,
        # ^ sep $
    '|',           0,
        # ^ outer $
    'x',           0,
    '*',           1,
        # ^ outer sep $
    '*|',          1,
    'x|',          0,
        # ^ sep outer $
    '|*',          1,
    '|x',          0,

        # ^ outer sep outer $
    '*|*',         2,

        # ^ outer pair …
    'x||',         0,
    'x|i|',        0,
    'x|*|',        0,
    '*||',         1,
    '*|i|',        1,
    '*|*|',        1,
    '*|*||i|',     1,
    'x||x',        0,
    'x|i|x',       0,
    'x|*|x',       0,
    'x|*||i|x',    0,
    '*||x',        1,
    '*|i|x',       1,
    '*|*|x',       1,
    '*|*||i|x',    1,
    'x|*||i|',     0,
    '*|*|*',       2,
    '*|a|a',       1,
    'a|*|a',       0,
    'a|a|*',       1,
    '*|*|x',       1,

        # ^ pair …
    '||',          0,
    '|i|',         0,
    '|*|',         0,

    '||x',         0,
    '|i|x',        0,
    '|*|x',        0,
    '|*||i|',      0,
    '|*|*',        1,
    '|*||i|x',     0,

        # ^ pair … trailing sep
    'p|*e*rl|w**e|*ekly|*x*|',          4,
    'p|*e*rl|w**e|*ekly||',             2,
    'th|ewe|e**|k|l***ych|alleng|e|',   5,
    'th|ewe|e**|k|l***ych|alleng|*e|',  6,
    'th|ewe|e**|k|l***ych|alleng|*e|e', 6,
    'th|ewe|e**|k|l***ych|alleng|*e|*', 7,

        # given
    'p|*e*rl|w**e|*ekly|',              2,
    'perl',                             0,
    'th|ewe|e**|k|l***ych|alleng|e',    5,
;
plan  @Test ÷ 2;

#use Grammar::Tracer;

grammar pair-exclus {
    rule  TOP     {     # The idea is to never re-traverse an <outer> …
        ^   [           # shorts
                ||                                            $
                || <sep>                                      $
                || <sep>            <outer>                   $
                || <outer>  [ $ || <sep> $ || <sep> <outer> ] $
            ]
          ||
            [
                ||          [  <pair>+ <outer>?  ]+  [ <sep> <outer>? ]?   $
                || <outer>  [  <pair>+ <outer>?  ]+  [ <sep>  <outer>? ]?  $
            ]
    }
    rule  pair   {  <sep> <inner>? <sep> }
    token inner  {  <-[ | ]>+ }
    token outer  {  <-[ | ]>+  }    # Rename/alias text w/o capture?
    rule text    {  <-[ | ]>+  }    # How to use named regex here?
    token sep    {  '|' }
}

class Count {
        # … so that no containing rule needs to filter <outer>.made
    my $char-sot = '*';
    method TOP($/)     { make sum $<outer>».made  }
    method outer($/)   { make  $/.comb.grep( $char-sot ).elems }
}

multi task( Any:U $data ) { die 'No match' }
multi task( $data -->Int) {
    my $match = pair-exclus.parse( $data, :actions(Count.new ));
    $match.made
}
for @Test -> $data, $exp {
    is task( $data), $exp, "$exp <~∘ $data";
}

done-testing;

my $str = 'th|ewe|e**|k|l***ych|alleng|*e|';

say "\nInput: \$str = $str.raku()\nOutput: &task( $str)"
