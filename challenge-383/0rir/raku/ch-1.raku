#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
383-1: Similar List        Submitted by: Mohammad Sajid Anwar
You are given three lists of strings.  Write a script to find out
if the first two list are similar with the help the third list. The
third list contains the similar words map.
=end comment

=begin x
    Coverage of a section is achieved with one or more of the section's words.
    Non-thesaurus words must be covered as an implicit section of one word.
=end x

my @Test =
    # exp   cmp1             cmp2             thesaurus-sections
    True,   ("a", "b"),      ("c", "d"),      (["a", "c"], ["b", "d"],),
    False,  ("a", "p"),      ("b", "p"),      (["a", "l"], ["l", "b"],),
    True,   ("p4", "py"),    ("ra", "py"),    (["p4", "p5", "ra"],),
    False,  ("e", "c"),      ("l", "w", "c"), (["e", "l"],),
    True,   ("f", "c"),      ("q", "v"),      (["q", "f"], ["v", "c"],),

    False,  ('a',    ),      ('c',    ),      (['a', 'b'], ['c','d'],),
    True,   ('a', 'a'),      ('b', 'b'),      (['a', 'b'], ['c','d'],),
    True,   ('a',    ),      ('a', 'a'),      (['a', 'b'], ['c','d'],),
    True,   ('a', 'c'),      ('a', 'c'),      (['a', 'b'], ['c','d'],),
    False,  ('a', 'c', 'x'), ('b', 'd', 'Y'), (['a', 'b'], ['c','d'],),
    True,   ('a', 'c', 'x'), ('b', 'd', 'x'), (['a', 'b'], ['c','d'],),
    True,   ('a', 'c', 'x'), ('b', 'd', 'x'), (['a', 'b'], ['c','d'], [],),
    True,   ('a', 'c', 'c', 'd', 'x'),
                             ('b', 'd', 'x'),
                                              (['a', 'b'], ['c','d'],),
;
plan +@Test ÷ 4;

multi task( @a, @b, @synonym, Bool :$ignore-extra -->Bool) {
    my Set @section = @synonym».Set;
    my Set $dict    = @synonym.flat.Set;
    my Set $l       = @a.Set;
    my Set $r       = @b.Set;

    return False unless ($l ∖ $dict) ≡ ($r ∖ $dict);  # match non-thesaurus
    for @section -> $cat {
        return False unless ( so $l ∩ $cat) == ( so $r ∩ $cat);
    }
    True;
}

for @Test -> $exp, @a, @b, @syn {
    is task( @a, @b, @syn),               $exp,
        ($exp // $exp.raku).fmt('%-5s ') ~ "<- @a[] ∘∘ @b[] ∘∘ @syn.raku()";
}
done-testing;


my $list1 = ("aa",              "nn",                           'w', 'x');
my $list2 = ("aa", "bb",        "mm",                           'w', 'x');
my $list3 = (["aa", "bb", "cc"], ["mm", "nn", "oo"], ["rr", "ss"]);

say qq{\nInput: \$list1 = ("$list1.join('", "')")};
say qq{       \$list2 = ("$list2.join('", "')")};
say qq{       \$list3 = }, $list3.raku().substr(1);
say qq{Output: }, task $list1, $list2, $list3;
