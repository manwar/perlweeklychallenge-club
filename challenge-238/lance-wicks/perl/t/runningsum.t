use Test2::V0 -target => 'RunningSum';

subtest "Example 1" => sub {
    my @in  = ( 1, 2, 3, 4,  5 );
    my @out = ( 1, 3, 6, 10, 15 );

    my $res = $CLASS->run(@in);
    is $res, \@out;
};

subtest "Example 2" => sub {
    my @in  = ( 1, 1, 1, 1, 1 );
    my @out = ( 1, 2, 3, 4, 5 );

    my $res = $CLASS->run(@in);
    is $res, \@out;
};

subtest "Example 3" => sub {
    my @in  = ( 0, -1, 1, 2 );
    my @out = ( 0, -1, 0, 2 );

    my $res = $CLASS->run(@in);
    is $res, \@out;
};
done_testing;
