# Collatz Conjecture
# Contributed by Ryan Thompson
#
# It is thought that the following sequence will always reach 1:
#
#     $n = $n / 2 when $n is even
#     $n = 3*$n + 1 when $n is odd
#
# For example, if we start at 23, we get the following sequence:
#
# 23 → 70 → 35 → 106 → 53 → 160 → 80 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
#
# Write a function that finds the Collatz sequence for any positive integer.
# Notice how the sequence itself may go far above the original starting number.
#
# Extra Credit
#
# Have your script calculate the sequence length for all starting numbers up to
# 1000000 (1e6), and output the starting number and sequence length for the
# longest 20 sequences.

sub collatz-seq($n) {
    if ($n == 1) {
        [1];
    } elsif ($n % 2 == 0) {
        [$n, |(collatz-seq($n / 2))];
    } else {
        [$n, |(collatz-seq(3 * $n + 1))];
    }
}

say collatz-seq(23);


# Extra Credit

# I have no good idea how to do this smart. I don't even know if there is a
# faster way. The Collatz Conjecture is a Conjecture for a reason of course.
# Therefore, I do it the lazy way:
#
# 1. Parallelize the whole search. Depending on the amount of threads this
#    speeds up tremendously.
# 2. Use cached to store older results. (I'm surprised this works well with
#    multi-threading)
#
# On my Intel i7 (4 cores, 8 threads) it still takes half an hour to compute.
# Results:
#
# 922524 444
# 922525 444
# 922526 444
# 938143 444
# 615017 446
# 410011 448
# 818943 449
# 820022 449
# 820023 449
# 546681 451
# 970599 457
# 767903 467
# 796095 467
# 511935 469
# 910107 475
# 927003 475
# 704623 503
# 939497 506
# 626331 508
# 837799 524

use experimental :cached;  # My favourite Raku feature!

sub collatz-length($n) is cached {
    if ($n == 1) {
        0;
    } elsif ($n % 2 == 0) {
        collatz-length($n / 2) + 1;
    } else {
        collatz-length(3 * $n + 1) + 1;
    }
}

my $collatz-list = Channel.new;
await (1..1e6).map: -> $n {
    start {
        $collatz-list.send((collatz-length($n), $n));
    }
}
$collatz-list.close();

for $collatz-list.list.sort.tail(20) -> ($l, $n) {
    say $n, ' ', $l;
}
