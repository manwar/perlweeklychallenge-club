use Test2::V0 -target => 'Bits';

subtest 'Example 1' => sub {
    is $CLASS->swap(101),154,'101 returns 154';
    note "Binary rep of 101 is '01100101' swapped is '10011010' -> 154 in decimal";
};

subtest 'Example 2' => sub {
    is $CLASS->swap(18),33,'18 returns 33';
    note "Binary rep of 18 is '00010010' swapped is '00100001' -> 33 in decimal";
};
done_testing;
