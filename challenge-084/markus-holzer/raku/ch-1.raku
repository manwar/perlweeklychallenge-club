unit sub MAIN( Int $i );

say -2147483647 <= $i <= 2147483647
    ?? $i.subst( / \d+ /, *.flip )
    !! 0;

