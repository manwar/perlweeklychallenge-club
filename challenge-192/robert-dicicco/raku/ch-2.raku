use v6;

#`{

  AUTHOR: Robert DiCicco

  DATE: 2022-11-23

  Challenge 192 Equal Distribution ( Raku )

 

  You are given a list of integers greater than or equal to zero, @list.

 

  Write a script to distribute the number so that each members are same. If you succeed then print the total moves otherwise print -1.

 

  Please follow the rules (as suggested by Neils van Dijke [2022-11-21 13:00]

 

  1) You can only move a value of '1' per move

  2) You are only allowed to move a value of '1' to a direct neighbor/adjacent cell

  -----------------------------------------------

  SAMPLE OUTPUT

  raku .\EqualDistribution.rk

  Input: @lst = (1 0 5)

          (1 1 4)

          (1 2 3)

          (1 3 2)

          (2 2 2)

  Output: 4

 

  Input: @lst = (0 2 0)

  Output: -1

 

  Input: @lst = (0 3 0)

          (1 2 0)

          (1 1 1)

  Output: 2

  -----------------------------------------------

}

 

my @lists = ([1,0,5], [0,2,0], [0,3,0]);

my $cnt;

 

sub MaxPos( @arr ) {

  my $max = 0;

  my $maxpos = -1;

  loop (my $x=0; $x < 3; $x++) {

    if (@arr[$x] > $max) {

      $max = @arr[$x];

      $maxpos = $x;

    }

  }

  return $max, $maxpos;

}

 

sub MinPos( @arr ) {

  my $min = 9;

  my $minpos = -1;

  loop (my $x=0; $x < 3; $x++) {

    if (@arr[$x] < $min) {

      $min = @arr[$x];

      $minpos = $x;

    }

  }

  return $min, $minpos;

}

 

sub GetTotalVal($arr) {

  my $sum = 0;

  for  (0 .. 2) -> $i

  {

    $sum += @$arr[$i];

  }

  return $sum

}

 

sub EvenUp( @arr) {

  $cnt++;

  my ($max, $maxpos) = MaxPos(@arr);

  my ($min, $minpos) = MinPos(@arr);

  print "\t(" ~ @arr ~ ")\n" if ($cnt > 1);

  @arr[$maxpos]--;

  ($maxpos == 0) || ($maxpos == 2) ?? @arr[1]++ !! @arr[$minpos]++;

  if ((@arr[0] == @arr[1] == @arr[2])) {

    print "\t(" ~ @arr ~ ")\n";

    say "Output: $cnt";

    say " ";

  } else {

    EvenUp(@arr);

  }

}

 

for (@lists) -> @lst {

  print("Input: \@lst = (" ~ @lst ~ ")\n");

  $cnt = 0;

  my $target = (GetTotalVal(@lst) / 3);

  $target >= 1 ?? EvenUp(@lst) !! say "Output: -1\n";

}
