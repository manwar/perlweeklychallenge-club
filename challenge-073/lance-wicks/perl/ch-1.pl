use Test2::V0 -target => 'Sliding';

subtest 'min_from_windows example' => sub {
    my @array       = ( 1, 5, 0, 2, 9, 3, 7, 6, 4, 8 );
    my $window_size = 3;
    my @expected    = ( 0, 0, 0, 2, 3, 3, 4, 4 );

    is $CLASS->min_from_windows(
        array_of_numbers => \@array,
        window_size      => $window_size,
        ),
        \@expected;
};

subtest 'min_from_windows test two' => sub {
    my @array       = ( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, );
    my $window_size = 3;
    my @expected    = ( 0, 1, 2, 3, 4, 5, 6, 7 );

    is $CLASS->min_from_windows(
        array_of_numbers => \@array,
        window_size      => $window_size,
        ),
        \@expected;

};

subtest 'min_from_windows test three' => sub {
    my @array       = ( 0, 1, 2, 3, 4, 5 );
    my $window_size = 2;
    my @expected    = ( 0, 1, 2, 3, 4 );

    is $CLASS->min_from_windows(
        array_of_numbers => \@array,
        window_size      => $window_size,
        ),
        \@expected;

};

subtest 'min_from_windows test three' => sub {
    my @array       = ( 99, 1, 32, 4, 5, 5 );
    my $window_size = 2;
    my @expected    = ( 1, 1, 4, 4, 5 );

    is $CLASS->min_from_windows(
        array_of_numbers => \@array,
        window_size      => $window_size,
        ),
        \@expected;

};

done_testing;
