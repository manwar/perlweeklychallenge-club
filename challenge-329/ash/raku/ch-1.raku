# Task 1 of The Weekly Challenge 329
# https://theweeklychallenge.org/blog/perl-weekly-challenge-329/#TASK1

say find-distinct-numbers('the1weekly2challenge2');
say find-distinct-numbers('go21od1lu5c7k');
say find-distinct-numbers('4p3e2r1l');

sub find-distinct-numbers($str) {
    (
        (
            $str ~~ m:g/ \d+ /
        )>>.Str
    ).unique
}
