use strict;
use warnings;
use feature 'say';
use experimental 'signatures';
use Data::Dumper;

# flattens matrix and starts the process. Needs width and height
sub spiral_matrix($matrix) {
    my $flat = [ map { $_->@* } $matrix->@* ];
    spiral($flat, int $matrix->@*, int $matrix->[0]->@*)
}

# accumulates the first 'row' and recursively repeats the
# process after 180º-rotating the rest of the 'matrix'
sub spiral($line, $height, $width, $acc = []) {
    return $height == 1
        ? [ $acc->@*, $line->@* ]
        : spiral(
            rotate([$line->@[$width .. $line->@* - 1]], $width),
            $width,
            $height - 1,
            [ $acc->@*, $line->@[0 .. $width - 1] ] )
}

# rotates the 'matrix'
sub rotate($line, $width, $index = $width - 1, $acc = []) {
    my $new_acc = [ $acc->@*, $line->[$index] ];
    return $index == $line->@* - $width
        ? $new_acc
        : rotate($line, $width, next_index($line, $index, $width), $new_acc)
}

# next index to process in the 'matrix'
sub next_index($line, $index, $width) {
    my $next = $index + $width;
    return $next > $line->@* ? ($next - 1) % $width : $next
}


sub spiral_matrix_backup($matrix, $acc = []) {    
    return $acc if $matrix->@* == 0;
    
    my $h = $matrix->@*;
    my $w = $matrix->[0]->@*;
    
    return [ map { $_->@* } $matrix->@* ] if $h > 1 && $w == 1;
    
    my $top_w = $w == 1 ? 1 : 2;
    my $top_h = $h == 1 ? 1 : 2;

    my @top    = $matrix->[0]->@[0 .. $w-$top_w];
    my @right  = ( map { $_->[$w - 1] } $matrix->@* )[0 .. $h-$top_h];
    my @bottom = ( reverse @{$matrix->[$h - 1]} )[0 .. $w-$top_w];
    my @left   = ( reverse map { $_->[0] } $matrix->@* )[0 .. $h-$top_h];
    my @core   = map { [ $_->@[1 .. $w-$top_w] ] } $matrix->@[1 .. $h-$top_h];
    
    push @{$acc}, @top;
    push @{$acc}, @right if $w > 1;
    push @{$acc}, @bottom if $h > 1;
    push @{$acc}, @left if $h > 1;
    
    return spiral_matrix(\@core, $acc);
}

if (@ARGV > 0) {
    say join q(, ), Dumper spiral_matrix(\@ARGV);
    exit 0;
}

sub rotator($matrix) {
    my $h = $matrix->@*;
    my $w = $matrix->[0]->@*;
    
    my @res = map { my $index = $_; [ map { $_->[$index] } $matrix->@* ] } reverse 0 .. $w - 1;
    
    say Dumper \@res;
}

say Dumper rotator([
[1, 2, 3],
[1, 2, 3],
[1, 2, 3],
]);


exit 0;

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
