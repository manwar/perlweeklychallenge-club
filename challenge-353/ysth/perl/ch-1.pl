use 5.036;
use List::Util 'max';

# https://theweeklychallenge.org/blog/perl-weekly-challenge-353/#TASK1

# Given an array of sentences, return the maximum number of words that appear in a single sentence.
sub max_words(@sentences) {
    # for our purposes here, a word is a group of non-space characters that includes a number or letter
    max map scalar(() = /(\S*?[\p{L}\p{N}]\S*)/g), @sentences
}

unless (caller) {
    require Run::WeeklyChallenge;
    Run::WeeklyChallenge::run_weekly_challenge(
        sub ($inputs) { max_words(@$inputs) },
        '["Hello world", "This is a test", "Perl is great"]',
        '{"type":"array", "items": {"type": "string"}}',
    );
}
