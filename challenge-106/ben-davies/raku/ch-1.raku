use v6;
unit sub MAIN(**@n where .all ~~ IntStr:D) {
    say @n.sort(&[R<=>]).rotor(2 => -1).map(&[-] ∘ |*).max;
}
