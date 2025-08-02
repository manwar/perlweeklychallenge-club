use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($array_ref, $word) {
    return 0 if scalar(@$array_ref) != length($word);
    for (my $i = 0; $i < scalar(@$array_ref); $i++) {
        return 0 if (substr($array_ref->[$i], 0, 1) ne substr($word, $i, 1));
    }
    return 1;
}

is(run(["Perl", "Weekly", "Challenge"], "PWC"), 1, "Example 1");
is(run(["Bob", "Charlie", "Joe"], "BCJ"), 1, "Example 2");
is(run(["Morning", "Good"], "MM"), 0, "Example 3");
