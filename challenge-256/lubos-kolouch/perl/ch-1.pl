use strict;
use warnings;

sub max_pairs {
    my @words = @_;
    my %word_set = map { $_ => 1 } @words;
    my $count = 0;
    foreach my $word (@words) {
        my $reversed = reverse $word;
        $count++ if exists $word_set{$reversed};
    }
    return int($count / 2);
}

# Tests
use Test::More;
is(max_pairs("ab", "de", "ed", "bc"), 1);
is(max_pairs("aa", "ba", "cd", "ed"), 0);
is(max_pairs("uv", "qp", "st", "vu", "mn", "pq"), 2);
done_testing();
