#! /usr/bin/env raku

unit sub MAIN (*@scores where @scores.elems > 0 && all(@scores) ~~ UInt, :v(:$verbose));

my %freq = @scores>>.Int.Bag;
my @sort = @scores.sort.squish.reverse;

say ": Frequency: { %freq.raku }" if $verbose;

my %gold = (1 => 'G', 2 => 'S', 3 => 'B'); 
my %rank;

for @sort -> $score
{
  state $rank = 1;
  %rank{$score} = %gold{$rank} // $rank;
  say ": Score $score with rank: %rank{$score} and frequency: %freq{$score}" if $verbose;
  $rank += %freq{$score};
}

say "(" ~ @scores.map({ %rank{$_} }).join(",") ~ ")";


