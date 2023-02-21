#!/usr/bin/env perl

=begin pod

-------------------------------------------------

AUTHOR: Robert DiCicco

DATE  : 2023-02-14

Challenge 204 Monotonic Array ( Perl )

-------------------------------------------------

=cut



use strict;

use warnings;

use feature qw/say/;

use feature qw(signatures);

no warnings 'experimental::signatures';



my @nums = ([1, 2, 2, 3],[1, 3, 2],[6, 5, 5, 4]);



sub CheckIncreasing ($a, $len) {

    my @arr = @$a;

    my $cnt = 0;

    while ($cnt < $len - 1) {

        $arr[$cnt + 1] >= $arr[$cnt] ? $cnt++ : return 0;

    }

    return 1;

}



sub CheckDecreasing ($a, $len) {

    my @arr=@$a;

    my $cnt = 0;

    while ($cnt < $len - 1) {

        $arr[$cnt + 1] <= $arr[$cnt] ? $cnt++ : return 0;

    }

     return 1;

}



#my $col;

for (my $col = 0; $col < scalar(@nums); $col++){

    my $len = scalar(@nums);

    print("Input: \@nums = (",@{$nums[$col]},")\n");

    say "0" if (CheckIncreasing(\@{$nums[$col]},$len) == 0) and (CheckDecreasing(\@{$nums[$col]},$len) == 0);

    say "1" if (CheckIncreasing(\@{$nums[$col]},$len) == 1) or (CheckDecreasing(\@{$nums[$col]},$len) == 1);

}

=begin pod

-------------------------------------------------

SAMPLE OUTPUT

perl .\Monotones.pl

Input: @nums = (1223)

1

Input: @nums = (132)

0

Input: @nums = (6554)

1

-------------------------------------------------
