use Test2::V0 -target => 'Triangle';

subtest 'min_path_sum' => sub {
    is $CLASS->min_path_sum( [ [1], [ 2, 4 ], [ 6, 4, 9 ], [ 5, 1, 7, 2 ] ] ),
        8,
        'Example 1 returns 8';

    is $CLASS->min_path_sum( [ [3], [ 3, 1 ], [ 5, 2, 3 ], [ 4, 3, 1, 3 ] ] ),
        7,
        'Example 2 returns 7';
};

subtest 'triangle_to_table' => sub {
    my $in = [ [1], [ 2, 4 ], [ 6, 4, 9 ], [ 5, 1, 7, 2 ] ];
    my $expected
        = [ [ 1, 0, 0, 0 ], [ 2, 4, 0, 0 ], [ 6, 4, 9, 0 ], [ 5, 1, 7, 2 ] ];
    is $CLASS->triangle_to_table($in), $expected, 'Example 1';

    $in = [ [3], [ 3, 1 ], [ 5, 2, 3 ], [ 4, 3, 1, 3 ] ];
    $expected
        = [ [ 3, 0, 0, 0 ], [ 3, 1, 0, 0 ], [ 5, 2, 3, 0 ], [ 4, 3, 1, 3 ] ];
    is $CLASS->triangle_to_table($in), $expected, 'Example 2';
};

ok 1;

done_testing;
