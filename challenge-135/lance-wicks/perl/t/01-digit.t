use Test2::V0 -target => 'Digit';

subtest 'Examples' => sub {
    is $CLASS->middle(1234567), 345;
    is $CLASS->middle(123),     123;
    is $CLASS->middle(-123),    123;
};

subtest 'Expected too short failures' => sub {
    is $CLASS->middle(), 'Too short', 'We need at least 3 digits';
    is $CLASS->middle(1),  'Too short', 'We need at least 3 digits';
    is $CLASS->middle(12), 'Too short', 'We need at least 3 digits';
};

subtest 'Expected even number faulures' => sub {
    is $CLASS->middle(1234),
        'Even number of digits',
        'Even number fails as expected';
    is $CLASS->middle(1234567890),
        'Even number of digits',
        'Even number fails as expected';
};

done_testing;
