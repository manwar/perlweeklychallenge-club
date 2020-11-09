unit sub MAIN( Int $i );

say -2³¹ <= $i <= 2³¹
    ?? $i.subst( / \d+ /, + *.flip )
    !! 0;

