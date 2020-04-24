#!/usr/bin/env perl6

use v6.d;

my $tree = {
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

say sprintf("Before: %s", $tree.raku);
mirror($tree.{1});
say sprintf("After : %s", $tree.raku);

sub mirror($branch) {

    ($branch.[0], $branch.[1]) = ($branch.[1], $branch.[0]);
    mirror($branch.[0][1]) if defined $branch.[0][1];
    mirror($branch.[1][1]) if defined $branch.[1][1];

    return $branch;
}
