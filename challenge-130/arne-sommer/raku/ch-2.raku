#! /usr/bin/env raku

use lib "lib";
use BinaryNode2;

unit sub MAIN (Str $tree = "8 | 5 9 | 4 6", :v(:$verbose));

my $btree = BinaryNode2.create($tree);

# say ": { $btree.raku }" if $verbose;

say + $btree.is-bst(:$verbose);

# say "Hello";