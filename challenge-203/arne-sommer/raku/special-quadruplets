#! /usr/bin/env raku

unit sub MAIN (*@nums where @nums.elems >= 4 && all(@nums) ~~ /^<[0..9]>*$/, :v(:$verbose));

my @combinations = (^@nums.elems).combinations(4);

say ": Combinations: { @combinations.map({ "(" ~ $_.join(", ") ~ ")" }).join(", ") }" if $verbose;

my $specials = 0;

for @combinations -> @candidate
{
  for @candidate.permutations -> ($a, $b, $c, $d)
  { 
    unless $a < $b < $c < $d
    {
      say ": a:$a b:$b c:$c d:$d - Not OK (Rule 2)" if $verbose;
      next
    }

    unless @nums[$a] + @nums[$b] + @nums[$c] == @nums[$d]
    {
      say ": a:$a b:$b c:$c d:$d - Not OK (Rule 1)" if $verbose;
      next;
    }

    $specials++;
    say ": a:$a b:$b c:$c d:$d - OK (Rule 1+2)" if $verbose;
  }
}

say $specials;
