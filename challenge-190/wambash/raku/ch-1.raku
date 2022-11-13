#!/usr/bin/env raku

sub capital-detection ($s) {
    $s
    andthen .contains: / ^ [ <:LC> <:Ll>+ | <:Lu>+ ] $ /
}

multi MAIN (Bool :test($)!) {
    use Test;
    is capital-detection('Perl'),  True;
    is capital-detection('TPRF'),  True;
    is capital-detection('PyThon'),False;
    is capital-detection('raku'),  True;
    done-testing;
}

multi MAIN ($s) {
    say +capital-detection $s
}
