#!/usr/bin/env raku
#
# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-092/

# Comments: https://andrewshitov.com/2020/12/21/raku-challenge-week-92-issue-1/

# unit sub MAIN(Str $a, Str $b);

# say + [==] ($a.comb.map: *.ord) <<->> ($b.comb.map: *.ord);
# say + [==] $a.ords <<->> $b.ords;

say + [==] [«-»] @*ARGS.map: *.ords;

# Test cases:
#
# $ raku ch-1.raku abc def
# 1
#
# $ raku ch-1.raku abb xyy
# 1
#
# $ raku ch-1.raku sum add
# 0
