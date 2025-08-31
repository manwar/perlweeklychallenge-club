#!/usr/bin/env raku

multi final-score-reducer (($score,@last ($l,*@)), 'D') {
    ($score + $l*2, ($l*2,|@last))
}

multi final-score-reducer (($score, ($l,*@rest)), 'C') {
    ($score-$l, @rest)
}

multi final-score-reducer (($score,@last ($f,$s,*@)), '+') {
    ($score+ $f+$s, ($f+$s,|@last))
}

multi final-score-reducer (($score,@last), Int() $n) {
  ($score+$n ,($n, |@last))
}

sub final-score (+scores) {
    scores
    andthen (0,()),|scores
    andthen .reduce: &final-score-reducer
    andthen .head
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply final-score(<5 2 C D +>), 30;
    is-deeply final-score("5","-2","4","C","D","9","+","+"), 27;
    is-deeply final-score(<7 D D C + 3>), 45;
    is-deeply final-score(<-5 -10 + D C +>), -55;
    is-deeply final-score(("3","6","+","D","C","8","+","D","-2","C","+")), 128;
    done-testing;
}

multi MAIN (+scores) {
    say final-score scores;
}
