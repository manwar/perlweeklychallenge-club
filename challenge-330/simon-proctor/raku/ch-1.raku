#!/usr/bin/env raku

subset ValidInput of Str where /^ <[a..z 0..9]>+ $/;

multi sub MAIN(:t(:$test)) is hidden-from-USAGE {
    use Test;
    is clear-digits("cab12"),"c";
    is clear-digits("xy99"), "";
    is clear-digits("pa1erl"), "perl";
    is clear-digits("1234a"), "a";
    is clear-digits("a123"),"";
    done-testing;
}

sub clear-digits(ValidInput $str is copy) {
    $str = loop-strip( $str, / \D?\d / );
    return $str;
}

sub loop-strip( $str is copy, $regex ) {
    my $new;
    repeat {
        $new = $str;
        $str ~~ s/ $regex //;
    } while $new ne $str;
    return $new;
}

#|( Given a string of letters and number
remove all the numbers and the left most
letter found before each one)
multi sub MAIN(
    ValidInput $str #= String made of letters and numbers
) {
    clear-digits($str).say;
}
