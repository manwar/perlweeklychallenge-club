#! /usr/bin/env raku

unit sub MAIN ($str where $str ~~ /^<[ a..z A .. Z ]>+$/,
               :v(:$verbose));

my @str     = $str.comb;
my $current = @str.shift;
my @nice;

while @str.elems
{
  if @str[0].lc eq $current.substr(0,1).lc
  {
    $current ~= @str.shift;
  }
  else
  {
    @nice.push: $current if $current.comb.unique.elems == 2;
    $current = @str.shift;
  }
}

@nice.push($current) if $current.comb.unique.elems == 2;

say ": Nice: { @nice.join(", ") }" if $verbose;

@nice .= sort({ $^b.chars <=> $^a.chars });

say ": Nice by length: { @nice.join(", ") }" if $verbose;

say @nice.first // "";
