#!/usr/bin/env raku

subset ValidInput of Str where * ~~ /^ <[a..z A..Z]> + $/;

multi sub MAIN(1) is hidden-from-USAGE {
    use Test;
    ok "WeEekly" ~~ ValidInput, 'Valid Input works';
    ok "1234" !~~ ValidInput, 'Valid input fails for invalid value'; 
    is good-string("WeEeekly"), "Weekly", "Exmaple 1 OK";
    is good-string("abBAdD"), "", "Example 2 OK";
    is good-string("abc"), "abc", "Exmaple 3 OK";
    done-testing;
}

sub good-string(ValidInput $str is copy) {
    my $new = '';
    while ($new !~~ $str) {
        $new = $str;
        $str = process($str);
    }
    return $new;
}

sub process(Str $str is copy) {
    $str ~~ s/ (<[a..z]>) {}:my $u = $0.uc; ($u) //;
    $str ~~ s/ (<[A..Z]>) {}:my $l = $0.lc; ($l) //;
    return $str;
}


#|(Given a string of upper and lowercase letter
remove all pairs of upper and lower case letters next
to each other recursively)
multi sub MAIN(
    ValidInput $str #= String made of upper and lowercase letters only
) {
    good-string($str).say;
}
