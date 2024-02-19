# Solution to the Task 1 of the Weekly Challenge #256
# https://theweeklychallenge.org/blog/perl-weekly-challenge-256/#TASK1

# Test run:
# % raku ch-1.raku
# 1
# 0
# 2

my @tests =
    ('ab', 'de', 'ed', 'bc'),
    ('aa', 'ba', 'cd', 'ed'),
    ('uv', 'qp', 'st', 'vu', 'mn', 'pq');

for @tests -> @words {
    say count-maximum-pairs(@words);
}

sub count-maximum-pairs(@words) {
    my @rev = @words.map: *.flip;
    my $words = (@words, @rev).Bag;

    my $pairs = $words.grep: *.value == 2; # Each pair is counted twice
    return $pairs.elems div 2;
}
