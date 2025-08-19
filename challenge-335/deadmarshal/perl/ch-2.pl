#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;
use List::Util qw(any);

sub find_winner{
  my ($m) = @_;
  my @cnt = (0) x 8;
  for(my $k = $#$m; $k >= 0; $k -= 2){
    my ($i,$j) = ($m->[$k][0],$m->[$k][1]);
    $cnt[$i]++;
    $cnt[$j+3]++;
    $cnt[6]++ if $i == $j;
    $cnt[7]++ if $i + $j == 2;
    if(any{$_ == 3} ($cnt[$i],$cnt[$j+3],$cnt[6],$cnt[7])) {
      return $k % 2 == 0 ? 'A' : 'B'
    }
  }
  @$m == 9 ? 'Draw' : 'Pending'
}

printf "%s\n",find_winner([[0,0],[2,0],[1,1],[2,1],[2,2]]);
printf "%s\n",find_winner([[0,0],[1,1],[0,1],[0,2],[1,0],[2,0]]);
printf "%s\n",find_winner([[0,0],[1,1],[2,0],[1,0],[1,2],[2,1],
			   [0,1],[0,2],[2,2]]);
printf "%s\n",find_winner([[0,0],[1,1]]);
printf "%s\n",find_winner([[1,1],[0,0],[2,2],[0,1],[1,0],[0,2]]);

