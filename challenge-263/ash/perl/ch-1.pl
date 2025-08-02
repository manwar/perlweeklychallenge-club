# Solution to Task 1 of The Weekly Challenge 263
# https://theweeklychallenge.org/blog/perl-weekly-challenge-263/#TASK1

# $ perl ch-1.pl
# (1, 2)
# ()
# (4)

use v5.20;
use experimental 'signatures';

my $tests = [
    [[1, 5, 3, 2, 4, 2], 2],
    [[1, 2, 4, 3, 5],    6],
    [[5, 3, 2, 4, 2, 1], 4]
];

for my $test (@$tests) {
    my $result = solve($test->[0], $test->[1]);
    say '(' . join(', ', @$result) . ')';
}

sub solve($data, $value) {
    my @sorted = sort(@$data);
    
    my @indices;
    for (my $c = 0; $c < scalar @sorted; $c++) {
        my $current = $sorted[$c];
        push @indices, $c if $current == $value;
        last if $current > $value;
    }

    return \@indices;
}
