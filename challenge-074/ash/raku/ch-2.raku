#!/usr/bin/env raku

# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-074/

# Comments: https://andrewshitov.com/2020/08/18/the-weekly-challenge-for-74/

my $s = 'ababc';
# my $s = 'xxyyzzyx';

for 1..$s.chars -> $pos {
    my $substr = $s.substr(0, $pos).join;
    print "In '$substr': ";
    my $b = bag $substr.comb;
    say $substr.comb.reverse.first({$b{$_} == 1}) // '#';
}
