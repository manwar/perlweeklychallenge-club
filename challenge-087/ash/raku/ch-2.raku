#!/usr/bin/env raku
#
# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-087/

my @m = < 0 0 0 1 0 0 >,
        < 1 1 1 0 0 0 >,
        < 0 0 1 0 0 1 >,
        < 1 1 1 1 1 0 >,
        < 1 1 1 1 1 0 >;

# Output:
# There’s a unit-only rectangle 2✕5 at position (3, 0) with the area 10.

my $w = @m.elems;
my $h = @m[0].elems;

my $A = 0;
my ($X, $Y, $ZX, $ZY);

my $count = 0;
for ^$w -> $x {
    for ^$h -> $y {
        for 2 .. $w - $x -> $zx {
            for 2 .. $h - $y -> $zy {
                my $area =
                    (($x ..^ $x + $zx X $y ..^ $y + $zy).map: -> ($a, $b) {
                        @m[$a][$b]
                    }).grep(1).elems;

                if $area == $zx * $zy && $area > $A {
                    $A = $area;
                    ($X, $Y, $ZX, $ZY) = $x, $y, $zx, $zy;
                }
            }
        }
    }
}

if $A {
    say "There’s a unit-only rectangle $ZX✕$ZY at position ($X, $Y) with the area $A.";
}
else {
    say 'No such rectangles found.';
}
