#!/bin/env raku

use MONKEY-SEE-NO-EVAL;

grammar Expression {
    rule TOP { <expression> }

    rule expression { <term>+ % <add-op> }
    rule term       { <item>+ % <mul-op> }
    rule item       { || '(' <expression> ')' || <number> }

    token add-op { '+' | '-' }
    token mul-op { '*' | '/' }
    token number { \d+ }
}

class ExpressionActions {
    method TOP($/) { make $<expression>.made }

    method expression($/) {
        my $n = $<term>[0].made;
        for $<add-op>».made Z $<term>[1..*]».made -> (\op, \term) {
            given op {
                when '+' { $n += term }
                when '-' { $n -= term }
            }
        }
        make $n;
    }

    method term($/) {
        my $n = $<item>[0].made;
        for $<mul-op>».made Z $<item>[1..*]».made -> (\op, \item) {
            given op {
                when '*' { $n   *= item }
                when '/' { $n div= item }
            }
        }
        make $n;
    }

    method item($/) { make $<expression>.defined ?? $<expression>.made !! $<number>.made }

    method add-op($/) { make $/.Str }
    method mul-op($/) { make $/.Str }
    method number($/) { make $/.Int }
}

my Str $s;

use Test;

repeat {
    $s = prompt 'Please enter an arithmetic expression: ';
    { put ''; last } unless $s;

    my $er = (EVAL $s).Int;
    my $gr = Expression.parse($s, :actions(ExpressionActions)).made;

    is $er, $gr, "'$s' = $gr, EVAL agrees with Grammar";
} while $s.chars > 0;

done-testing;
