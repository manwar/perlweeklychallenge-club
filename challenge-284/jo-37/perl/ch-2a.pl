#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use Tree::RB::XS ':cmp';
use experimental 'signatures';

our $examples;

run_tests() if $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [N1,N2,... M1,M2,...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N1,N2,...
    numbers in \@list1, comma and/or space separated

M1,M2,...
    numbers in \@list2, comma and/or space separated

EOS


### Input and Output

say "(@{relative_sort(map [split /[, ] */, $_], @ARGV)})";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/09/08/ch-284.html#task-2

sub relative_sort ($list1, $list2) {
    my $part1 = Tree::RB::XS->new(compare_fn => CMP_INT, track_recent => 1);
    my $part2 = Tree::RB::XS->new(compare_fn => CMP_INT);
    $part1->insert($_, 0) for @$list2;
    ${\($part1->get($_) // $part2->get_or_add($_))}++ for @$list1;

    [
        map +($_->key) x $_->value,
            $part1->iter_newer->next('*'),
            $part2->iter->next('*')
    ];
}

### Examples and tests

sub run_tests {

    is relative_sort([2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5],
            [2, 1, 4, 3, 5, 6]), [2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9],
            'example 1';
    is relative_sort([3, 3, 4, 6, 2, 4, 2, 1, 3],
            [1, 3, 2]),
            [1, 3, 3, 3, 2, 2, 4, 4, 6],
            'example 2';
    is relative_sort([3, 0, 5, 0, 2, 1, 4, 1, 1],
            [1, 0, 3, 2]),
            [1, 1, 1, 0, 0, 3, 2, 4, 5],
            'example 3';
    done_testing;

    exit;
}
