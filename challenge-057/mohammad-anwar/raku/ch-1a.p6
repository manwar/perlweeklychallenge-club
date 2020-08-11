#!/usr/bin/env perl6

use Test;

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

my $exp_1 = {
    1 => [ [ 3,
             [ [ 7 ],
               [ 6 ],
             ],
           ],
           [ 2,
             [ [ 5 ],
               [ 4 ],
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

my $exp_2 = {
    1 => [ [ 3,
             [ [ 7,
                 [ [ 9 ],
                   [ 8 ],
                 ],
               ],
               [ 6 ],
             ],
           ],
           [ 2,
             [ [ 5 ],
               [ 4 ],
             ],
           ],
         ],
};

mirror($tree_1.{1});
mirror($tree_2.{1});

is-deeply $tree_1, $exp_1, "testing tree 1";
is-deeply $tree_2, $exp_2, "testing tree 2";

done-testing;

sub mirror($branch) {

    ($branch.[0], $branch.[1]) = ($branch.[1], $branch.[0]);
    mirror($branch.[0][1]) if defined $branch.[0][1];
    mirror($branch.[1][1]) if defined $branch.[1][1];

    return $branch;
}
