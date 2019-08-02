sub is-anagram (Str $word1, Str $word2) {
    return $word1.comb.Bag === $word2.comb.Bag;
}
for <ban bane post stop pots stop post pots pots taps> -> $w1, $w2 {
    say "$w1 $w2:\t", is-anagram $w1, $w2;
}
