#!/usr/bin/env raku

# Tests fired if called with test parameter
multi sub MAIN(:t(:$test)) is hidden-from-USAGE {
    use Test;
    is nice-string("YaaAho"), "aaA";
    is nice-string("cC"), "cC";
    is nice-string("A"), "";
    done-testing;
}

subset ValidInput of Str where m/^ <[a..z A..Z]>+ $/;

sub nice-string( ValidInput $str ) {
    my @letters = $str.comb;
    my $upper = @letters ∩ ("A".."Z");
    my $lower = @letters ∩ ("a".."z");
    my %both;
    for "a".."z" -> $str {
        if ($str.uc ∈ $upper) && ($str ∈ $lower) {
            %both{$str} = True;
            %both{$str.uc} = True;
        }
    }
    return @letters.grep( { %both{$_} } ).join("");
}

#|(Given a string made of upper and lower case
letter print the string with any letters not
included in both cases removed)
multi sub MAIN(
    ValidInput $str #= A String made of lower and uppercase letters
) {
    nice-string($str).say;
}
