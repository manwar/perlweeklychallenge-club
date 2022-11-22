#!/usr/bin/env perl

=begin pod

AUTHOR: Robert DiCicco

DATE: 2022-11-22

Challenge 192 Equal Distribution ( Perl )



You are given a list of integers greater than or equal to zero, @list.



Write a script to distribute the number so that each members are same. If you succeed then print the total moves otherwise print -1.



Please follow the rules (as suggested by Neils van Dijke [2022-11-21 13:00]



1) You can only move a value of '1' per move

2) You are only allowed to move a value of '1' to a direct neighbor/adjacent cell



SAMPLE OUTPUT

perl .\EqualDistribution.pl

Input: @lst = (1 0 5)

        1 1 4

        1 2 3

        1 3 2

        2 2 2

Output: 4



Input: @lst = (0 2 0)

Output: -1



Input: @lst = (0 3 0)

        1 2 0

        1 1 1

Output: 2

output

perl .\EqualDistribution.pl

Input: @lst = (1 0 5)

        1 1 4

        1 2 3

        1 3 2

        2 2 2

Output: 4



Input: @lst = (0 2 0)

Output: -1



Input: @lst = (0 3 0)

        1 2 0

        1 1 1

Output: 2



=cut



use strict;

use warnings;

use feature qw/say/;

use signatures;



my @list = ([1,0,5], [0,2,0], [0,3,0]);

my $cnt;



sub MaxPos( $arr ) {

  my $max = 0;

  my $maxpos = -1;

  for (my $x=0; $x < 3; $x++) {

    if (@$arr[$x] > $max) {

      $max = @$arr[$x];

      $maxpos = $x;

    }

  }

  return $max, $maxpos;

}



sub MinPos( $arr ) {

  my $min = 9;

  my $minpos = -1;

  for (my $x=0; $x < 3; $x++) {

    if (@$arr[$x] < $min) {

      $min = @$arr[$x];

      $minpos = $x;

    }

  }

  return $min, $minpos;

}



sub EvenUp( $arr) {

  $cnt++;

  my ($max, $maxpos) = MaxPos($arr);

  my ($min, $minpos) = MinPos($arr);

  say "\t@$arr" if ($cnt > 1);

  @$arr[$maxpos]--;

  ($maxpos == 0) || ($maxpos == 2) ? @$arr[1]++ : @$arr[$minpos]++;

  if ((@$arr[0] == @$arr[1] == @$arr[2])) {

    say "\t@$arr";

    say "Output: $cnt";

    say " ";

  } else {

    EvenUp($arr);

  }

}



sub GetTotalVal($arr) {

  my $sum = 0;

  foreach my $i (0 .. 2)

  {

    $sum += @$arr[$i];

  }

  return $sum

}



for my $lst (@list) {

  say "Input: \@lst = (@$lst)";

  $cnt = 0;

  my $target = (GetTotalVal($lst) / 3);

  $target >= 1 ? EvenUp($lst) : say "Output: -1\n";

}
