use Test2::V0 -target => EDS;

isa_ok( $CLASS, 'EDS' );
can_ok( $CLASS, 'element_sum' );
can_ok( $CLASS, 'digit_sum' );
can_ok( $CLASS, 'absolute_diff' );

subtest "Example 1" => sub {
    my @ints = ( 1, 2, 3, 45 );
    my $got  = $CLASS->element_sum(@ints);

    is $got, 51, 'element_sum should return 51';

    $got = $CLASS->digit_sum(@ints);
    is $got, 15, 'digit_sum should return 15';

    $got = $CLASS->absolute_diff(@ints);
    is $got, 36, 'absolute_diff should return 36';
};

subtest "Examples 2-4" => sub {

    my @tests = (
        {   name          => 'Example 2',
            ints          => [ 1, 12, 3 ],
            element_sum   => 16,
            digit_sum     => 7,
            absolute_diff => 9,
        },
        {   name          => 'Example 3',
            ints          => [ 1, 2, 3, 4 ],
            element_sum   => 10,
            digit_sum     => 10,
            absolute_diff => 0,
        },
        {   name          => 'Example 4',
            ints          => [ 236, 416, 336, 350 ],
            element_sum   => 1338,
            digit_sum     => 42,
            absolute_diff => 1296,
        },
    );

    for my $test (@tests) {
        subtest $test->{name} => sub {
            for my $method (qw/element_sum digit_sum absolute_diff/) {
                my $got = $CLASS->$method( $test->{ints}->@* );
                is $got, $test->{$method},
                    "$test->{name} should give $method of $test->{$method}";
            }
        };
    }

};

done_testing;
