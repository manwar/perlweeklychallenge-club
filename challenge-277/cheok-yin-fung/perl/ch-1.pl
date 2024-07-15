# The Weekly Challenge 277
# Task 1 Count Common
use v5.30.0;
use warnings;
use List::MoreUtils qw/singleton duplicates/;

sub cc {
    my @words1 = $_[0]->@*;
    my @words2 = $_[1]->@*;
    my @commons = duplicates ((singleton @words1),(singleton @words2));
    return scalar @commons;
}

use Test::More tests=>3;
ok cc(
    ["Perl", "is", "my", "friend"],
    ["Perl", "and", "Raku", "are", "friend"]
  ) == 2;
ok cc(
    ["Perl", "and", "Python", "are", "very", "similar"],
    ["Python", "is", "top", "in", "guest", "languages"]
  ) == 1;
ok cc(
    ["Perl", "is", "imperative", "Lisp", "is", "functional"],
    ["Crystal", "is", "similar", "to", "Ruby"]
  ) == 0;
