#!/usr/bin/env perl6

use v6.c;

#Perl weekly challenge 012.2:

# Write a script that finds the common directory path, given a collection
# of paths and directory separator. For example, if the following paths
# are supplied.

# This solution demonstrates the creation of an infix operator and
# its use as a reduction meta-operator. Use --help for details

use Test;

sub infix:<common-prefix>(@a, @b) {
    gather for @a Z @b -> ($a, $b) {
        ($a ~~ $b and take $a but True) or last;
    }
}

sub common-leading-paths(@paths, :$separator='/') {
    return join $separator, [common-prefix] @paths.map: *.split($separator);
}

proto MAIN(|) {*}
multi MAIN(Bool :$test!) {
    ok (<a b c> common-prefix <a b q>) ~~ <a b>, "common-prefix infix op";
    ok ([common-prefix] [<a b c>, <a b q r>, <a b>]) ~~ <a b>, "common-prefix reduction";
    ok common-leading-paths(<a$b a$c>, :separator<$>) eq 'a', "common-leading-paths with sep";
    # Example from the puzzle
    ok common-leading-paths(</a/b/c/d /a/b/cd /a/b/cc /a/b/c/d/e>) eq '/a/b', "puzzle sample";
}

multi MAIN(Str :$separator='/', *@paths) {
    say common-leading-paths @paths, :$separator;
}
