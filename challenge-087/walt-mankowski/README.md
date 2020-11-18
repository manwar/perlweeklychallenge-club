Solutions by Walt Mankowski.

# Task #1: Longest Consecutive Sequence

For this task we're given an unsorted array of integers, and we need to find the longest unsorted sequence of consecutive number and print it out. If there are no consecutive numbers, we print 0.

I start by sorting the sequence. Then I make a single pass through the sequence looking for entries that are one greater than the entry before them. I use 3 state variables to track my progress:
* `$best_start` is the start position of the best run I've found so far.
* `$best_run` is the length of the best run I've found so far.
* `$start` is the start of the current run, or -1 if there isn't a current run.
With these it's a straightforward task to loop through the sorted list and find the best sequence.
```perl
my @n = sort {$a <=> $b} @ARGV;

my $best_start = 0;
my $best_run = 0;
my $start = -1;

for my $i (1..$#n) {
    # are we in a run?
    if ($n[$i] == $n[$i-1] + 1) {
        # is this the start of a run?
        $start = $i-1 if $start == -1;

        # do we have a new best run?
        if ($i - $start > $best_run) {
            $best_run = $i - $start;
            $best_start = $start;
        }

    } else {
        # we're not in a run
        $start = -1;
    }
}
```
Then I can print out the best sequence using an array slice:
```perl
if ($best_run > 0) {
    say "@n[$best_start..$best_start+$best_run]";
} else {
    say 0;
}
```
