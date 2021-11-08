use Test2::V0 -target => 'Salesman';
use Test::Output;

subtest 'Testing the script output' => sub {
    require './ch-2.pl';

    stdout_is { &run() }
    "Input: length = 10\ntour = (0 2 1 3 0)", 'Example 1';

};

subtest 'Salesman::route' => sub {
    my $stops
        = [ [ 0, 5, 2, 7 ], [ 5, 0, 5, 3 ], [ 3, 1, 0, 6 ], [ 4, 5, 4, 0 ], ];
    is $CLASS->route($stops),
        {
        length => 10,
        tour   => [ 0, 2, 1, 3, 0 ]
        },
        'Example 1 route';

    $stops = [
        [ 0, 5,  2, 7, 9 ],
        [ 5, 0,  5, 3, 9 ],
        [ 3, 1,  0, 6, 9 ],
        [ 4, 5,  4, 0, 3 ],
        [ 2, 16, 5, 5, 0 ]
    ];
    is $CLASS->route($stops),
        {
        length => 11,
        tour   => [ 0, 2, 1, 3, 4, 0 ]
        },
        'Example 1 route';
};

subtest 'Salesman::closest' => sub {
    is $CLASS->closest( [ 0, 5, 2, 7 ] ), [ 2, 2 ],
        'Shortest is city 2 (zero indexed), with distance of 2';
    is $CLASS->closest( [ 5, 0, 5, 3 ] ), [ 3, 3 ],
        'Shortest is city 3 (zero indexed), with distance of 3';
    is $CLASS->closest( [ 3, 1, 0, 6 ] ), [ 1, 1 ],
        'Shortest is city 1 (zero indexed), with distance of 1';
    is $CLASS->closest( [ 4, 5, 4, 0 ] ), [ 0, 4 ],
        'Shortest is city 0 (zero indexed), with distance of 4';

};

done_testing;
