#!/usr/bin/env raku

multi sub MAIN(:t(:$test)) is hidden-from-USAGE {
    use Test;
    is final-score("5","2","C","D","+"), 30;
    is final-score("5","-2","4","C","D","9","+","+"), 27;
    is final-score("7","D","D","C","+","3"), 45;
    is final-score("-5","-10","+","D","C","+"), -55;
    is final-score("3","6","+","D","C","8","+","D","-2","C","+"), 128;
    done-testing;
    
}
