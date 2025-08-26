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

subset ValidScore of Str where /^ "-"?\d+ || "D" || "C" || "+" $/;

multi sub MAIN(*@scores  where all(@scores) ~~ ValidScore ) {
    final-score(|@scores).say;
}

sub final-score(*@scores where all(@scores) ~~ ValidScore ) {
    my @results = [];
    for @scores -> $score {
        given $score {
            when ( 'C' ) {
                @results.pop;
                succeed;
            }
            when ( "D") {
                @results.push( @results[*-1] * 2);
                succeed;
            }
            when ("+") {
                @results.push( @results[*-1] + @results[*-2] );
                succeed;
            }
            default { @results.push($score.Int) }
        }
    }
    return [+] @results;
}
