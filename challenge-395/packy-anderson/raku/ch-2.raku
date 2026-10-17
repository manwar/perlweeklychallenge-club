#!/usr/bin/env raku
use v6;

sub isSquare(@words) {
  my @square = [ @words.map({$_.comb}) ];
  my $len    = @words[0].chars - 1;
  for 0 .. $len-1 -> $i {
    for $i+1 .. $len -> $j {
      return False unless @square[$i][$j] eq @square[$j][$i];
    }
  }
  return True;
}

sub wordSquare(@words) {
  for @words.combinations(@words[0].chars) -> @list {
    for @list.permutations -> $perm {
      return $perm if isSquare($perm);
    }
  }
}

sub solution(@words) {
  say 'Input: @words = (' ~ @words.map({ qq/"$_"/}).join(', ') ~ ')';
  my $square = wordSquare(@words);
  say 'Output: (' ~ $square.map({ qq/"$_"/}).join(', ') ~ ")\n";
  for $square.split(/\s+/) -> $word {
    say "    " ~ $word.comb.join(" ");
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
