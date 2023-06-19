use Test2::V0 -target => 'Good::Strings';

subtest "Example 1" => sub {
    my @words    = ( "cat", "bt", "hat", "tree" );
    my $chars    = "atach";
    my $expected = 6;

    is $CLASS->sum_lengths( \@words, $chars, ), $expected;

};

subtest "Example 2" => sub {
    my @words    = ( "hello", "world", "challenge" );
    my $chars    = "welldonehopper";
    my $expected = 10;

    is $CLASS->sum_lengths( \@words, $chars, ), $expected;
};

subtest "Edge case: unable to build any words" => sub {
    # This test proves a bug I found when writing the
    # script. If unable to build a word we would get
    # a warning.

    my @words    = ( "hello", "world", "challenge" );
    my $chars    = "xxx";
    my $expected = 0;

    my $got;
    ok no_warnings { $got = $CLASS->sum_lengths( \@words, $chars, ); };
    is $got, $expected;

};

subtest "_build_word" => sub {
    is $CLASS->_build_word(
        word  => 'cat',
        chars => {
            c => 'c',
            a => 'a',
            t => 't',
        },
        ),
        'cat';

    is $CLASS->_build_word(
        word  => 'cat',
        chars => {
            c => 'c',
            a => 'a',
        },
        ),
        'ca';
};

done_testing;

