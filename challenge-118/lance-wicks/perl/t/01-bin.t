use Test2::V0 -target => 'Binary::Palindrome';

subtest 'Examples' => sub {
    is $CLASS->is_palindrome(5), 1, '5 is a binary palindrome';
    is $CLASS->is_palindrome(4), 0, '4 is NOT a binary palindrome';

    is $CLASS->is_palindrome(99), 1, '99 is a binary palindrome';
    is $CLASS->is_palindrome(98), 0, '98 is NOT a binary palindrome';
};

subtest 'Binary representation' => sub {
    is $CLASS->represent_as_binary(5), '101', '5 --> 101';
    is $CLASS->represent_as_binary(4), '100', '4 --> 100';

    is $CLASS->represent_as_binary(99), '1100011', '99 --> 1100011';
    is $CLASS->represent_as_binary(98), '1100010', '98 --> 1100010';
};

done_testing;
