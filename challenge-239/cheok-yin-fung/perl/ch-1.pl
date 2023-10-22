# The Weekly Challenge 239
# Task 1 Same String
use v5.30.0;
use warnings;

sub ss {
    return (join "", $_[0]->@*) eq (join "", $_[1]->@*);
}

use Test::More tests=>3;
ok ss(["ab", "c"], ["a", "bc"]);
ok !ss(["ab", "c"], ["ac", "b"]);
ok ss(["ab", "cd", "e"] ,["abcde"]);
