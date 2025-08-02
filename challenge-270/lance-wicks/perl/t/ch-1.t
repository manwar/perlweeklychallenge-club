use Test2::V0 -target => 'Special';

subtest 'Example 1' => sub {
    my $matrix = [
        [ 1, 0, 0 ],    #
        [ 0, 0, 1 ],    #
        [ 1, 0, 0 ],    #
    ];

    my $got = $CLASS->count_positions($matrix);
    is $got, 1;
};

subtest 'Example 2' => sub {
    my $matrix = [
        [ 1, 0, 0 ],    #
        [ 0, 1, 0 ],    #
        [ 0, 0, 1 ],    #
    ];
    my $got = $CLASS->count_positions($matrix);
    is $got, 3;
};

subtest 'Extra test 1' => sub {
    my $matrix = [
        [ 1, 0, 0 ],    #
        [ 1, 0, 0 ],    #
        [ 1, 0, 0 ],    #
    ];
    my $got = $CLASS->count_positions($matrix);
    is $got, 0;
};

subtest 'Extra test 2' => sub {
    my $matrix = [
        [ 1, 1, 1 ],    #
        [ 0, 0, 0 ],    #
        [ 0, 0, 0 ],    #
    ];
    my $got = $CLASS->count_positions($matrix);
    is $got, 0;
};

subtest "Positions generator" => sub {
    is $CLASS->coords_list, [
        [ 0, 0 ], [ 0, 1 ], [ 0, 2 ],    #
        [ 1, 0 ], [ 1, 1 ], [ 1, 2 ],    #
        [ 2, 0 ], [ 2, 1 ], [ 2, 2 ],    #
        ],
        'Should return the correct set of coords';
};

subtest "Position test" => sub {
    my $matrix = [
        [ 1, 0, 0 ],                     #
        [ 0, 0, 1 ],                     #
        [ 1, 0, 0 ],                     #
    ];

    is $CLASS->is_special( $matrix, 0, 0 ), 0;
    is $CLASS->is_special( $matrix, 0, 1 ), 0;
    is $CLASS->is_special( $matrix, 0, 2 ), 0;

    is $CLASS->is_special( $matrix, 1, 0 ), 0;
    is $CLASS->is_special( $matrix, 1, 1 ), 0;
    is $CLASS->is_special( $matrix, 1, 2 ), 1;

    is $CLASS->is_special( $matrix, 2, 0 ), 0;
    is $CLASS->is_special( $matrix, 2, 1 ), 0;
    is $CLASS->is_special( $matrix, 2, 2 ), 0;
};

done_testing;
