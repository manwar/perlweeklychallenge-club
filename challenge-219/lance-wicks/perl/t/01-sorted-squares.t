use Test2::V0 -target => 'My::Sorted::Square';

subtest 'Example 1' => sub {
    my @list    = ( -2, -1, 0, 3, 4 );
    my @squares = $CLASS->run(@list);
    is \@squares, [ 0, 1, 4, 9, 16 ];
};

subtest 'Example 2' => sub {
    my @list    = ( 5, -4, -1, 3, 6 );
    my @squares = $CLASS->run(@list);
    is \@squares, [ 1, 9, 16, 25, 36 ];
};

done_testing;
