# Perl code for "Same String" problem

use strict;
use warnings;
use Test::More;

sub same_string {
    my ($arr1_ref, $arr2_ref) = @_;

    return join("", @$arr1_ref) eq join("", @$arr2_ref);
}

is(same_string(["ab", "c"], ["a", "bc"]), 1, "Test case 1");
is(same_string(["ab", "c"], ["ac", "b"]), '', "Test case 2");
is(same_string(["ab", "cd", "e"], ["abcde"]), 1, "Test case 3");

done_testing();

