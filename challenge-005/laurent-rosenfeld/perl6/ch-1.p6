sub is-anagram (Str $word1, Str $word2) {
    return False if $word1.chars != $word2.chars;
    return $word1.comb.sort eq $word2.comb.sort;
}
for <ban bane post stop pots stop post pots pots taps> -> $w1, $w2 {
    say "$w1 $w2:\t", is-anagram $w1, $w2;
}
