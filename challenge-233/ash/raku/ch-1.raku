# Solution to Task 1 of The Weekly Challenge 233
# https://theweeklychallenge.org/blog/perl-weekly-challenge-233/#TASK1

# Description:
# https://andrewshitov.com/2023/09/04/working-with-words-in-the-raku-programming-language/

# Test run:
#
# $ raku ch-1.raku
# Test case: [aba aabb abcd bac aabc]
# ab: [(aba aabb)]
# abc: [(bac aabc)]
# Answer: 2 pairs.

# Test case: [aabb ab ba]
# ab: [(aabb ab) (aabb ba) (ab ba)]
# Answer: 3 pairs.

# Test case: [nba cba dba]
# Answer: 0 pairs.

my @tests = ["aba", "aabb", "abcd", "bac", "aabc"],
            ["aabb", "ab", "ba"],
            ["nba", "cba", "dba"];

for @tests -> @words {
    say "Test case: ", @words;

    my %classification = @words.classify(*.comb.unique.sort.join).grep(*.value.elems > 1);

    my $pairs = 0;
    for %classification.kv -> $k, $v {
        my @pairs = $v.combinations(2);
        $pairs += @pairs.elems;

        say "$k: ", @pairs;
    }
    say "Answer: $pairs pair{$pairs == 1 ?? '' !! 's'}.\n";
}
