use Test2::V0 -target => 'Binary::Palindrome';

subtest 'Examples' => sub {
    is $CLASS->is_palindrome(5), 1, '5 is a binary palindrome';
    is $CLASS->is_palindrome(4), 0, '4 is NOT a binary palindrome';
};

subtest 'Binary representation' => sub {
    is $CLASS->represent_as_binary(5), '101', '5 --> 101';
    is $CLASS->represent_as_binary(4), '100', '4 --> 100';
};

done_testing;
