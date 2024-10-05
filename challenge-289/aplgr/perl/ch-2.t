use strict;
use warnings;
use Test::More;
require './ch-2.pl';

# Test cases for jumble_word
my @word_tests = (
    { input => 'abc', desc => 'Test case 1: Short word remains unchanged' },
    { input => 'word', desc => 'Test case 2: First and last letter remain the same' },
    { input => 'jumbled', desc => 'Test case 3: First and last letter remain the same' },
);

# Run tests for jumble_word
foreach my $test (@word_tests) {
    my $jumbled = jumble_word($test->{input});

    # Check if the first and last letter remain the same
    is(substr($jumbled, 0, 1), substr($test->{input}, 0, 1), "$test->{desc} - First letter remains the same");
    is(substr($jumbled, -1), substr($test->{input}, -1), "$test->{desc} - Last letter remains the same");
    cmp_ok([sort split('', $test->{input})], 'cmp', [sort split('', $jumbled)], "$test->{desc} - All letters are preserved");
}

# Test cases for jumble_text
my $input_text = "According to a research at Cambridge University, it doesn't matter in what order the letters in a word are.";
my $jumbled_text = jumble_text($input_text);

my @input_words = split(/\W+|_/, $input_text);
my @jumbled_words = split(/\W+|_/, $jumbled_text);

for (my $i = 0; $i < scalar @input_words; $i++) {
    is(substr($jumbled_words[$i], 0, 1), substr($input_words[$i], 0, 1), "First letter remains the same for '$input_words[$i]'");
    is(substr($jumbled_words[$i], -1), substr($input_words[$i], -1), "Last letter remains the same for '$input_words[$i]'");
    cmp_ok([sort split('', $input_words[$i])], 'cmp', [sort split('', $jumbled_words[$i])], "All letters are preserved for '$input_words[$i]'");
}

done_testing();
