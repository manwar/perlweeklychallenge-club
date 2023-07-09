#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
224-1: Special Notes        Submitted by: Mohammad S Anwar

Given two strings, $source and $target, find out if using the characters
(only once) from source, a target string can be created.

Example 1
Input: $source = "abc"
       $target = "xyz"
Output: false
Example 2
Input: $source = "scriptinglanguage"
       $target = "perl"
Output: true
Example 3
Input: $source = "aabbcc"
       $target = "abc"
Output: true
=end comment

=begin consideration
    It seems that "aabb" would allow 'aab' to be True. Depends on the
    definition of 'character'.
=end consideration

my @Test =
    # source                target      set      bag 
    "aabbcc",               "abc",      True,   True,
    "scriptinglanguage",    "perl",     True,   True,
    "abc",                  "xyz",      False,  False,
    'a',                    'a',        True,   True,
    'aa',                   'a',        True,   True,
    'aa',                   'aa',       False,  True,
    'aa',                   'ab',       False,  False,
;
plan @Test ÷ 2;

sub func( $src, $trg, Bool :$bag -->Bool) {
    my ($s, $t) = ($src.comb.Bag, $trg.comb.Bag);
    return $t ⊆ $s if $bag;
    return $t ⊆ $s.Set;
}

for @Test -> $src, $trg, $set, $bag {
    is func($src, $trg      ), $set, "$trg <- $src (set)";
    is func($src, $trg, :bag), $bag, "$trg <- $src (bag)";
}
done-testing;

my $source = 'apple';
my $dest   = 'leap';
say qq{\n\$source = "$source"\n\$target = "$dest"};
say "Output: &func($source, $dest)             set required";
my $dest = 'apple';
say qq{\n\$source = "$source"\n\$target = "$dest"};
say "Output: &func($source, $dest)             set required";
say qq{\n\$source = "$source"\n\$target = "$dest"};
say "Output: &func($source, $dest, :bag)          dupes per source";
exit;

