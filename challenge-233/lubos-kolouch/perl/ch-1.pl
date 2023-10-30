use strict;
use warnings;
use Test::More;

use strict;
use warnings;
use Test::More;

sub similar_words {
    my @words = @_;
    my %count;

    # Convert words into a set of unique characters and count occurrences
    for my $word (@words) {
        my $unique_chars = join '', sort keys %{{ map { $_ => 1 } split //, $word }};
        $count{$unique_chars}++;
    }

    # Calculate total count of similar words
    my $total = 0;
    for my $v (values %count) {
        $total += $v * ($v - 1) / 2;
    }

    return $total;
}

is(similar_words("aba", "aabb", "abcd", "bac", "aabc"), 2, 'Test Case 1');
is(similar_words("aabb", "ab", "ba"), 3, 'Test Case 2');
is(similar_words("nba", "cba", "dba"), 0, 'Test Case 3');

done_testing();

