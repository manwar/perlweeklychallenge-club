#!/usr/bin/env perl
use v5.36;

my @inputs = (
    ['perl', 'loves', 'scala'],
    ['love', 'the', 'programming'],
    ['java', 'awk', 'kotlin', 'node.js'],
);

foreach my $input (@inputs) {
    printf "Input: [%s]\n", join ', ', @$input;

    my $is_circular = all_words_are_circular($input) ? 'true' : 'false';
    say "Output: $is_circular\n"
}

# Takes an arrayref of words, and checks whether, for each pair of words in the
# list, the last letter of the first word equals the first letter of the next word.
sub all_words_are_circular($words) {
    return 0 unless scalar @$words > 1;

    foreach my $i (0 .. $#$words) {
        my $first_word  = $words->[$i];
        my $second_word = $words->[$i + 1];

        last unless $second_word;

        return 0 unless substr($first_word, -1) eq substr($second_word, 0, 1);
    }

    return 1;
}

