#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my $deepest_path = do {
    local $/;
    $+{c} if <DATA> =~ m|^ (?<c> (?: /[^\n/]+ )+ ) (?&c) (?: \n\g{c} (?&c) )+ $|x;
};

is( $deepest_path, '/a/b/c', "is '$deepest_path' the deepest path?" );

done_testing( 1 );

__DATA__
/a/b/c/1/x.pl
/a/b/c/d/e/2/x.pl
/a/b/c/d/3/x.pl
/a/b/c/4/x.pl
/a/b/c/d/5/x.pl
