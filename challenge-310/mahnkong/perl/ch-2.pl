use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@ints) {
    my @odd;
    my @even;
    my @result;

    for (my $i = 0; $i < scalar(@ints); $i ++) {
        my $ref = ($i % 2 == 0) ? \@even : \@odd;
        push @$ref, $ints[$i];
    }

    @even = sort { $a <=> $b } @even;
    @odd = sort { $b <=> $a } @odd;

    for (my $i = 0; $i < scalar(@ints); $i ++) {
        my $ref = ($i % 2 == 0) ? \@even : \@odd;
        push @result, shift @$ref;
    }
    return \@result;
}

is_deeply(run(4, 1, 2, 3), [2, 3, 4, 1], "Example 1");
is_deeply(run(3, 1), [3, 1], "Example 2");
is_deeply(run(5, 3, 2, 1, 4), [2, 3, 4, 1, 5], "Example 3");
