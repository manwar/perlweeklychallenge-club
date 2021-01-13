#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Data::Dump qw(dump);

my $tree_1 = {
    1 => [ [ 2,
             [ [ 4 ],
               [ 5 ],
             ],
           ],
           [ 3,
             [ [ 6 ],
               [ 7 ],
             ],
           ],
         ],
};

my $tree_2 = {
    1 => [ [ 2,
             [ [ 4 ],
               [ 5 ],
             ],
           ],
           [ 3,
             [ [ 6 ],
               [ 7,
                 [ [ 8 ],
                   [ 9 ],
                 ],
               ],
             ],
           ],
         ],
};

mirror($tree_1->{1});
mirror($tree_2->{1});

is (dump($tree_1), "{ 1 => [[3, [[7], [6]]], [2, [[5], [4]]]] }", "testing tree 1");
is (dump($tree_2), "{ 1 => [[3, [[7, [[9], [8]]], [6]]], [2, [[5], [4]]]] }", "testing tree 2");

done_testing;

sub mirror {
    my ($branch) = @_;

    ($branch->[0], $branch->[1]) = ($branch->[1], $branch->[0]);
    mirror($branch->[0][1]) if defined $branch->[0][1];
    mirror($branch->[1][1]) if defined $branch->[1][1];

    return $branch;
}
