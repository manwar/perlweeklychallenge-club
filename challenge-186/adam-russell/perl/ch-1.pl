use v5.36;
use strict;
use warnings;
##
# You are given two lists of the same size.
# Create a subroutine sub zip() that merges the two lists.
##
sub zip($a, $b){
    return map { $a->[$_], $b->[$_] } 0 .. @$a - 1;
}

MAIN:{
    print join(", ", zip([qw/1 2 3/], [qw/a b c/])) . "\n";
    print join(", ", zip([qw/a b c/], [qw/1 2 3/])) . "\n";
}