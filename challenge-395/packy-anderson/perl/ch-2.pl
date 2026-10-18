#!/usr/bin/env perl
use v5.44;

use Algorithm::Combinatorics qw( combinations permutations );

sub isSquare(@words) {
  my @square = map { [ split //, $_ ] } @words;
  my $len    = length($words[0]) - 1;
  for my $i ( 0 .. $len-1 ) {
    for my $j ( $i+1 .. $len ) {
      return false unless $square[$i][$j] eq $square[$j][$i];
    }
  }
  return true;
}

sub wordSquare(@words) {
  for my $list ( combinations(\@words, length($words[0])) ) {
    for my $perm ( permutations($list) ) {
      return @$perm if isSquare(@$perm);
    }
  }
}

sub solution($words) {
  say 'Input: @words = (' . join(', ', map { qq/"$_"/ } @$words) . ')';
  my @square = wordSquare(@$words);
  say 'Output: (' . join(', ', map { qq/"$_"/ } @square) . ")\n";
  for my $word ( @square )  {
    say "    " . join(" ", split //, $word);
  }
}

say "Example 1:";
solution(["MA", "AM", "MY", "ME"]);

say "\nExample 2:";
solution(["SUN", "USE", "NET", "SEE", "TEN"]);

say "\nExample 3:";
solution(["BOAT", "TEAL", "AREA", "TSAR", "OGRE"]);

say "\nExample 4:";
solution(["CARD", "AREA", "REAR", "DART"]);

say "\nExample 5:";
solution(["HEART", "TREND", "EMBER", "RESIN", "ABUSE"]);

