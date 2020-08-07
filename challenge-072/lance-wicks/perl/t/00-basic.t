use Test2::V0 -target => 'Trailing::Zeroes';

subtest 'Just testing the count of trailing zeroes' => sub {
   is $CLASS->count(3628800), 2, 'Should calculate 3628800 has 2 trailing zeroes';
   is $CLASS->count(5040),    1, 'Should calculate 5040 has 1 trailing zeroes';
   is $CLASS->count(24),      0, 'Should calculate 24 has 1 trailing zero';
};

subtest 'Calculate factorial' => sub {
    my $input = 10;
    my $expected = 3628800;
    is $CLASS->factorial($input), $expected, "factorial of $input should be $expected";

    $input = 7;
    $expected = 5040;
    is $CLASS->factorial($input), $expected, "factorial of $input should be $expected";

    $input = 4;
    $expected = 24;
    is $CLASS->factorial($input), $expected, "factorial of $input should be $expected";
};


done_testing;
