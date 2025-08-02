#!/usr/bin/env raku

sub broken-keys ($name, $typed) {
    my  \name-rex = rx {^ <$_>  $} with $name.subst: /(\w)  /, {$_ ~ '+'},:global; #)>

    $typed.contains: name-rex
}

multi MAIN (Bool :test($)!) {
    use Test;
    is broken-keys('perl','perrrl'),True;
    is broken-keys('peerl','perrrl'),False;
    is broken-keys('raku','rrakuuuu'),True;
    is broken-keys('python','perl'),False;
    is broken-keys('coffeescript','cofffeescccript'),True;
    is broken-keys('cofffeescccript','coffeescript'),False;
    done-testing;
}

multi MAIN ($name, $typed) {
    say broken-keys $name, $typed
}
