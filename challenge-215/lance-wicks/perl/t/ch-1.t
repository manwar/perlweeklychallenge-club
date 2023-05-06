use Test2::V0 -target => 'OddOneOut';

subtest 'Module structure' => sub {
    isa_ok( $CLASS, 'OddOneOut' );
};

=pod

You are given a list of words (alphabetic characters only) of same size.

Write a script to remove all words not sorted alphabetically and print the number of words in the list that are not alphabetically sorted.

=cut

subtest 'Functionality' => sub {
    my @words = ( 'abc', 'xyz', 'tsu' );
    my $result = $CLASS->count(@words);
    is $result, 1, 'Example 1 should return "1"';

    @words = ( 'rat', 'cab', 'dad' );
    $result = $CLASS->count(@words);
    is $result, 3, 'Example 2 should return "3"';

    @words = ('x', 'y', 'z');
    $result = $CLASS->count(@words);
    is $result, 0, 'Example 3 should return "0"';

};

subtest 'Is word alpha sorted' => sub {
    is $CLASS->is_word_not_alpha_order('abc'), 0, '"abc" is aplha order (0)';
    is $CLASS->is_word_not_alpha_order('cab'), 1, '"cab" is NOT alpha order (1)';
};

done_testing;
