#!/usr/bin/env raku
#
# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-087/

my @n = 5, 100, 12, 2, 13, 3, 14, 4;

@n.=sort;

my $start = 0;
my $end = 0;
my @longest = ($start, $end);
for 1 ..^ @n -> $i {
    if @n[$i] - @n[$i - 1] == 1 {
        $end++;
    }
    else {
        @longest = ($start, $end) if ([-] @longest) > $start - $end;
        $start = $end = $i;
    }
}

if ([-] @longest) > -1 {
    say 0;
}
else {
    put @n[@longest[0] .. @longest[1]];
}
