# Task 1 of the Weekly Challenge 385
# https://theweeklychallenge.org/blog/perl-weekly-challenge-385/#TASK1

my @cases =
    ["apple banana apple", "banana orange"],
    ["cat dog", "bird fish"],
    ["the quick brown fox", "the quick"],
    ["hello", "hello"],
    ["blue blue red", "red green green yellow"]
;

for @cases -> @case {
    say ([(^)] @case.words).keys
}
