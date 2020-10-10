unit sub MAIN( *@N where .all ~~ Int );

given (1..@N.max) ∖ (@N>>.Int) {
    say .elems 
        ?? "Smallest missing element is {.min.key}"
        !! "No missing elements" } 