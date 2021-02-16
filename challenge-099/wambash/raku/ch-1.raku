#!/usr/bin/env raku

sub pattern-match ( $s, $p ) {
    my $re = $p.trans: < * ? > => < .* . >;
    $s.match: / ^ <$re> $ /
}

multi MAIN (Bool :$test!) {
    use Test;
    ok  pattern-match('abcde', 'a*e');
    nok pattern-match('abcde', 'a*d');
    nok pattern-match('abcde', '?b*d');
    ok  pattern-match('abcde', 'a*c?e');
    done-testing;
}

multi MAIN ($s, $p) {
    say +so pattern-match $s, $p
}
