use strict;
use warnings;
use feature 'say';
use experimental 'signatures';
use Data::Dumper;

sub spiral_matrix($matrix, $acc = []) {
    return $acc if $matrix->@* == 0;
    my @new_acc = ($acc->@*, (shift $matrix->@*)->@*);

    spiral_matrix(rotator($matrix), \@new_acc);
}

sub rotator($matrix) {
    return [] if $matrix->@* == 0;
    my $w = $matrix->[0]->@*;

    [map {my $i = $_;[ map {$_->[$i]} $matrix->@* ]} reverse 0 .. $w - 1]
}

if (@ARGV > 0) {
    say join q(, ), Dumper spiral_matrix(\@ARGV);
    exit 0;
}

use Test::More;

is_deeply spiral_matrix([
[ 1 ],
]),
[ 1 ],
'One number';

is_deeply spiral_matrix([
[ 1, 2, 3 ],
]),
[ 1, 2, 3 ],
'One row';

is_deeply spiral_matrix([
[ 1 ],
[ 2 ],
[ 3 ],
]),
[ 1, 2, 3 ],
'One column';

is_deeply spiral_matrix([
[ 1, 2, 3 ],
[ 1, 2, 3 ],
]),
[ 1, 2, 3, 3, 2, 1 ],
'Two rows';

is_deeply spiral_matrix([
[ 1, 7 ],
[ 2, 8 ],
[ 3, 9 ],
]),
[ 1, 7, 8, 9, 3, 2 ],
'Two columns';

is_deeply spiral_matrix([
[ 1, 2, 3 ],
[ 1, 2, 3 ],
[ 1, 2, 3 ],
]),
[ 1, 2, 3, 3, 3, 2, 1, 1, 2 ],
'Three rows';

is_deeply spiral_matrix([
[ 1, 7, 4 ],
[ 2, 8, 5 ],
[ 3, 9, 6 ],
]),
[ 1, 7, 4, 5, 6, 9, 3, 2, 8 ],
'Three columns';

is_deeply spiral_matrix([
[ 1, 2, 3, 0 ],
[ 4, 5, 6, 0 ],
[ 4, 9, 1, 0 ],
[ 7, 8, 9, 1 ],
]),
[ 1, 2, 3, 0, 0, 0, 1, 9, 8, 7, 4, 4, 5, 6, 1, 9 ],
'4x4 matrix';

is_deeply spiral_matrix([
[ 1, 2, 3 ],
[ 4, 5, 6 ],
[ 7, 8, 9 ],
]),
[ 1, 2, 3, 6, 9, 8, 7, 4, 5 ],
'Example 1';

is_deeply spiral_matrix([
[  1,  2,  3,  4 ],
[  5,  6,  7,  8 ],
[  9, 10, 11, 12 ],
[ 13, 14, 15, 16 ],
]),
[ 1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10 ],
'Example 2';

done_testing;
