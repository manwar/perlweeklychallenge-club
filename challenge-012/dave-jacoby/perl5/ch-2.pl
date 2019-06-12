#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say state };
no warnings qw{ experimental::postderef };

my @paths;
push @paths, '/a/b/c/d';
push @paths, '/a/b/cd';
push @paths, '/a/b/cc';
push @paths, '/a/b/c/d/e';

# should allow user input and perhaps pull into a subroutine
# eh, exercise for a reader

# before: ["/a/b/c/d", "/a/b/cd"]

my @p2 = map { [ split m{/} ] } grep { m{^/} } @paths;

# after: [["","a","b","c","d"],["","a","b","c"]]

# while loops are worrying, but this should never go farther than the
# shortest path in the list
while (1) {
    state $c = 0;
    my $d = 0;

    for my $p (@p2) {

        # first pass, I had separate cases for "end of path"
        # and "paths separate", but then I stepped back and 
        # applied more clever

        # I'm checking the nth (or, rather, cth) position in each
        # array with the same position of the first array, and also
        # if that's defined. In the case where you have one or more
        # paths like /a/b/c/d/e/f/g, the answer will be /a/b/c/d/e/f/g

        if ( !defined $p2[$d][$c] || $p2[0][$c] ne $p2[$d][$c] ) {

            # say join '/', $p2[0][ 0 .. $c - 1];
            #    Use of uninitialized value $. in range (or flip) at ./c2.pl line 43.
            # which is weird. I guess you cannot get slices of postdereferenced
            # arrayrefs. Who knew? So we use map instead.

            # and, since there's a problem with $c, we go to $c - 1

            say join '/', map { $p2[0][$_] } 0 .. $c - 1;
            exit;
        }
        $d++;
    }
    $c++;
}

# /a/b

exit;

