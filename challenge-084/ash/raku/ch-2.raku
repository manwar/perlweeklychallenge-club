#!/usr/bin/env raku
#
# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-084/

# Output: 1 for this matrix
# my @m = < 0 1 0 1 >,
#         < 0 0 1 0 >,
#         < 1 1 0 1 >,
#         < 1 0 0 1 >;

# Output: 4 for this matrix
my @m = < 1 1 0 1 >,
        < 1 1 0 0 >,
        < 0 1 1 1 >,
        < 1 0 1 1 >;

my $w = @m.elems;
my $h = @m[0].elems;

my $count = 0;
for ^$w -> $x {
    for ^$h -> $y {
        for 1..* -> $z {
            last if $x + $z >= $w || $y + $z >= $h;

            $count++ if all(
                @m[$x; $y     ], @m[$x + $z; $y     ],
                @m[$x; $y + $z], @m[$x + $z; $y + $z]
            );
        }
    }
}

say $count;
