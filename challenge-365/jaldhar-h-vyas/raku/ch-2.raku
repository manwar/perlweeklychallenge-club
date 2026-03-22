#!/usr/bin/raku

sub isValidToken($token) {

    my $digit = rx/ \d /;
    if $token.match(/ $digit /) {
        return False;
    }

    my $hyphen = rx/ \- /;
    if $token.match(/ ($hyphen) /, :g) &&
    ($/.elems != 1 || !$token.match(/ <lower> $hyphen <lower> /)) {
        return False;
    }

    my $punct = rx/<[\!\.\,]>/;
    if $token.match(/ ($punct) /, :g) &&
    ($/.elems != 1 || !$token.match(/$punct $/)) {
        return False;
    }

    return True;
}

sub MAIN(
    Str $str
) {
    $str.split(/\s+/).grep({ isValidToken($_) }).elems.say
}
