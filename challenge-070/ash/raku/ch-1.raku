#!/usr/bin/env raku

# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-070/

# Comments: https://andrewshitov.com/2020/07/20/raku-challenge-week-70-issue-1/

my $s = 'perlandraku';
my $c = 3;
my $o = 4;

my @s = $s.comb;
for 1..$c -> $x {
    my $y = ($x + $o) % $s.chars;
    @s[$x, $y] = @s[$y, $x];
}
$s = @s.join('');

say $s;

# Output:
# pndraerlaku
