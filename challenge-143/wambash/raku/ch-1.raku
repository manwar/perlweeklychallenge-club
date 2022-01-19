#!/usr/bin/env raku

grammar Calcurator {
    token TOP  { <exprs> }
    rule exprs { <element> + %% <operator> }
    token element { <number> | <in-bracket> }
    token number  { \d+ }

    proto token operator {*}
    token operator:sym<+> { <sym> }
    token operator:sym<-> { <sym> }
    token operator:sym<*> { <sym> }

    proto token in-bracket {*}
    token in-bracket:sym<()> { '(' ~ ')' <exprs> }
}

class Calculate {
    method TOP    ($/) { make $<exprs>.made }
    method exprs  ($/) {
        make ($<element>.head.made, |($<operator>».made Z $<element>.skip».made)).reduce: -> $r, (&op, $e) { $r [&op] $e }
    }
    method element($/) { make $/.values.head.made }
    method number ($/) { make $/.Numeric }
    method in-bracket:sym<()> ($/) { make $<exprs>.made }
    method operator:sym<+> ($/) { make &[+] }
    method operator:sym<-> ($/) { make &[-] }
    method operator:sym<*> ($/) { make &[*] }
}

sub calcurator ( $s ) {
     Calcurator.parse($s,actions => Calculate).made
}

multi MAIN (Bool :test($)!) {
    use Test;
    without Calcurator {
        is .parse('10', :rule<number>), 10;
        is .parse('10', :rule<number>,actions => Calculate).made, 10;
        is .parse('10', :rule<element>), 10;
        is .parse('10', :rule<element>,actions => Calculate).made, 10;
    }
    is calcurator('10 + 20 -5'), 25;
    is calcurator('(10 + 20 - 5) * 2 '), 50;
    is calcurator('(10 + 20 - 5) * (2 + 3)'), 125;
    done-testing;
}

multi MAIN ($s) {
    say calcurator $s
}
