#!/usr/bin/env raku

sub list-of-parents ($path) {
    $path
    andthen .IO
    andthen $_, *.parent ... '/'.IO
    andthen .map: *.Str
}

sub common-path (+@path) {
    @path
    andthen .categorize: &list-of-parents
    andthen .nodemap: *.elems
    andthen .max: {.value, .key.chars}\
    andthen .key
}

multi MAIN (Bool :test($)!) {
    use Test;
    is list-of-parents('/a/b/c/d/e/2/x.pl ')[2],"/a/b/c/d/e";
    is common-path(
        </a/b/c/1/x.pl
        /a/b/c/d/e/2/x.pl
        /a/b/c/d/3/x.pl
        /a/b/c/4/x.pl
        /a/b/c/d/5/x.pl
        >
    ), '/a/b/c';
    done-testing;
}

multi MAIN (+@path) {
    say common-path @path
}

multi MAIN () {
    lines()
    andthen .map: *.trim
    andthen common-path $_
    andthen .say
}
