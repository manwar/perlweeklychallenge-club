use Test2::V0 -target => 'FNR';

subtest 'from_string()' => sub {
    subtest 'Example 1' => sub {
        note "Input: ‘ababc’";
        note "Output: ‘abb#c’";
        is $CLASS->from_string('ababc'), 'abb#c',
            'The first example is correct';
    };

    subtest 'Example 2' => sub {
        note "Input: ‘xyzzyx’";
        note "Output: ‘xyzyx#’";

        is $CLASS->from_string('xyzzyx'), 'xyzyx#',
            'The second example is correct';

    };
};

subtest '_fnr()' => sub {
    my %tests = (
        'a'     => 'a',
        'ab'    => 'b',
        'aba'   => 'b',
        'abab'  => '#',
        'ababc' => 'c'
    );

    while ( my ( $input, $expected ) = each %tests ) {
        is $CLASS->_fnr($input), $expected, "$input should return $expected";
    }
};

done_testing;
