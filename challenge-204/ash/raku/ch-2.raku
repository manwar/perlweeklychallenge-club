# A Raku solution to the Task 2 "Reshape Matrix" of the Weekly Challenge 204
# https://theweeklychallenge.org/blog/perl-weekly-challenge-204/#TASK2
# Solved together with ChatGPT. The whole dialogue with the machine is published in my blog:
# https://andrewshitov.com/2023/02/13/solving-task-2-of-the-weekly-challenge-204-with-the-help-of-chatgpt/

# Test run:
# $ raku ch-2.raku 
# [1 2 3 4]
# [[1 2] [3 4] [5 6]]
# [[1] [2]]
# 0

sub reshape-matrix (@matrix, $r, $c) {
    my @flat = @matrix.map(*.flat).flat;
    my $total_elements = @flat.elems;
    return 0 if $total_elements != $r * $c;

    my @result;
    for ^$r -> $i {
        push @result, [@flat[$c * $i .. $c * $i + $c - 1]];
    }

    return @result.elems == 1 ?? @result[0] !! @result;
}

my @matrix = [ [ 1, 2 ], [ 3, 4 ] ];
my $r = 1;
my $c = 4;
my $result = reshape-matrix(@matrix, $r, $c);
say $result;

@matrix = [ [ 1, 2, 3 ], [ 4, 5, 6 ] ];
$r = 3;
$c = 2;
$result = reshape-matrix(@matrix, $r, $c);
say $result;

@matrix = [ [ 1 ], [ 2 ] ];
$r = 2;
$c = 1;
$result = reshape-matrix(@matrix, $r, $c);
say $result;

@matrix = [ [ 1, 2, 3 ], [ 4, 5, 6 ] ];
$r = 2;
$c = 4;
$result = reshape-matrix(@matrix, $r, $c);
say $result;
