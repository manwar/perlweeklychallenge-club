use Test2::V0 -target => 'Descriptive';

subtest 'is_self_desc' => sub {
    is $CLASS->is_self_desc(1210), 1, '1210 is a self describing number';
    is $CLASS->is_self_desc(1), 0, '1 is NOT a self describing number';
};

subtest 'list' => sub {
    is $CLASS->list, [1210,2020,21200], 'List returns the first three numbers';
};


done_testing;
