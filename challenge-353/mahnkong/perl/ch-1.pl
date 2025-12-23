use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@sentences) {
    my $max = 0;
    foreach my $sentence (@sentences) {
        my @words = split / /, $sentence;
        $max = scalar(@words) if scalar(@words) > $max
    }
    return $max;
}

is(run("Hello world", "This is a test", "Perl is great"), 4, "Example 1");
is(run("Single"), 1, "Example 2");
is(run("Short", "This sentence has seven words in total", "A B C", "Just four words here"), 7, "Example 3");
is(run("One", "Two parts", "Three part phrase", ""), 3, "Example 4");
is(run("The quick brown fox jumps over the lazy dog", "A", "She sells seashells by the seashore", "To be or not to be that is the question"), 10, "Example 5");
